FROM debian:jessie
ENV DEBIAN_FRONTEND noninteractive

MAINTAINER muze-nl

RUN sed -e 's@main$@main contrib non-free@'  -i /etc/apt/sources.list

# Commands
RUN \
		apt-get update && \
		apt-get upgrade -y && \
		apt-get --no-install-recommends install -y openssh-client php5-cli curl && \
		apt-get clean && \
		rm -r /var/lib/apt/lists/*
RUN \
	curl  https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

RUN \
	curl http://deployer.org/releases/v3.3.0/deployer.phar -o /usr/local/bin/dep && \
	chmod a+rx /usr/local/bin/dep && \
	echo -e "Host *\n\tStrictHostKeyChecking no\n\tPasswordAuthentication no\n\n" | tee -a /etc/ssh/ssh_config
