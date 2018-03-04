FROM ruby:2.3

ARG SCUMBLR_TAG=master
ENV SCUMBLR_TAG ${SCUMBLR_TAG}
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev \
        libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties \
        libffi-dev libmagickcore-dev libmagickwand-dev imagemagick imagemagick-common postgresql-common \
        postgresql-client libpq-dev wget && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler sidekiq --no-ri --no-rdoc

RUN mkdir /app && \
    wget -O - https://github.com/Netflix/Scumblr/archive/${SCUMBLR_TAG}.tar.gz | tar -C /app --strip-components 1 -xzf - && \
    cd /app && \
    bundle install

RUN mkdir -p /app/custom/config
ADD custom-config-database.yml /app/custom/config/database.yml
ADD config-initializers-redis.rb /app/config/initializers/redis.rb

WORKDIR /app

ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
