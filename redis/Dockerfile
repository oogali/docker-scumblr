# Source from Idle Pattern's Ubuntu 14.x
FROM idlepattern/ubuntu-14

# Housekeeping/attribution
MAINTAINER "Omachonu Ogali" <oogali@idlepattern.com>
ENV container docker

RUN apt-get update && apt-get -y install redis-server

RUN sed -i 's/^daemonize yes/daemonize no/; s/^bind 127.0.0.1/bind 0.0.0.0/; s/^logfile .*/logfile ""/' /etc/redis/redis.conf

USER redis
EXPOSE 6379
CMD /usr/bin/redis-server /etc/redis/redis.conf
