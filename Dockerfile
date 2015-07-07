FROM ubuntu:12.04
ENV LUMBERJACK_VERSION 0.4.0
ENV PATH /go/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

RUN apt-get update \
	&& apt-get install -yqq build-essential python-software-properties wget unzip git

RUN apt-get update \
        && (grep -E 1[02].04 /etc/os-release ; if [ $? -eq 0 ] ; then git clone https://go.googlesource.com/go && cd go && git checkout go1.4.1 && cd src && GOROOT=/usr/local ./all.bash ; fi) \
        && (grep 14.04 /etc/os-release ; if [ $? -eq 0 ] ; then apt-get install -yqq golang ; fi)

RUN apt-get update \
        && (grep 1[02].04 /etc/os-release ; if [ $? -eq 0 ] ; then apt-get -yqq install ruby1.9.1 ruby1.9.1-dev ; fi) \
        && (grep 14.04 /etc/os-release ; if [ $? -eq 0 ] ; then apt-get -yqq install ruby ruby-dev ; fi) && gem install fpm 
	
RUN mkdir -p /app \
	&& mkdir -p /app/src \
	&& mkdir -p /app/bin \
	&& wget -O/app/src/logstash-forwarder-${LUMBERJACK_VERSION}.zip https://github.com/elasticsearch/logstash-forwarder/archive/v${LUMBERJACK_VERSION}.zip \
	&& echo ${LUMBERJACK_VERSION} > /app/lumberjack-version.txt	

RUN gem install bundler

WORKDIR /app/src
RUN unzip logstash-forwarder-${LUMBERJACK_VERSION}.zip
WORKDIR logstash-forwarder-${LUMBERJACK_VERSION}
RUN bundle --binstubs
RUN PATH=$GOPATH/bin:$PATH
RUN bundle exec make
RUN bundle exec make deb

CMD cp /app/src/logstash-forwarder-${LUMBERJACK_VERSION}/logstash-forwarder_${LUMBERJACK_VERSION}_amd64.deb /pkg

