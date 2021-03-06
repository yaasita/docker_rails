FROM ubuntu:latest
MAINTAINER yaasita

#apt
RUN apt-get update
RUN apt-get upgrade -y

#package
RUN apt-get install -y  \
    autoconf \
    automake \
    bison \
    build-essential \
    curl \
    dnsutils \
    git \
    htop \
    imagemagick \
    imagemagick-dbg \
    libapr1-dev \
    libcurl4-openssl-dev \
    libmagick++-dev \
    libreadline-dev \
    libreadline6 \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    openssl \
    vim \
    zlib1g \
    zlib1g-dev

# ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd/
RUN mkdir /root/.ssh
ADD authorized_keys /root/.ssh/authorized_keys
RUN perl -i -ple 's/^(permitrootlogin\s)(.*)/\1yes/i' /etc/ssh/sshd_config
RUN echo root:root | chpasswd

# supervisor
RUN apt-get install -y supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
