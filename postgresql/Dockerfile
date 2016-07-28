# Source from Idle Pattern's Ubuntu 14.x
FROM idlepattern/ubuntu-14

# Housekeeping/attribution
MAINTAINER "Omachonu Ogali" <oogali@idlepattern.com>
ENV container docker

RUN apt-get update && apt-get -y install postgresql

VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf
RUN echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/9.3/main/pg_hba.conf

USER postgres
EXPOSE 5432
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
