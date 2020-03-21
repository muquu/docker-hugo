FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV LANG=en_US.UTF-8
ENV HUGO_VERSION=0.68.0

#RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y tzdata locales \
  && echo "${TZ}" > /etc/timezone \
  && rm /etc/localtime \
  && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && locale-gen en_US.UTF-8 ja_JP.UTF-8 \
  && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y curl git python-pygments
RUN curl -fL -o hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.deb
RUN apt-get install -y ./hugo.deb
RUN rm -rf /var/lib/apt/lists/*