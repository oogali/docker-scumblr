FROM alpine

ARG RUBY_VERSION=2.3.1

RUN apk add --no-cache bash build-base curl git libffi-dev readline-dev \
      libxml2-dev libxslt-dev yaml-dev zlib-dev sqlite-dev libpq gcc \
      autoconf bison libtool postgresql-dev linux-headers \
      tzdata ncurses-dev

# Set time zone to UTC
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime && echo "UTC" > /etc/timezone

# Install rbenv, plus the ruby-build and rbenv-gemset plugins
RUN git clone --depth 1 https://github.com/sstephenson/rbenv.git /usr/local/rbenv && \
    git clone --depth 1 https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build && \
    git clone --depth 1 https://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset && \
    /usr/local/rbenv/plugins/ruby-build/install.sh

# Configure rbenv
ADD etc-profile.d-rbenv.sh /etc/profile.d/rbenv.sh

# Install and select the version of Ruby this project needs
RUN bash --login -c "rbenv install ${RUBY_VERSION} && rbenv global ${RUBY_VERSION} && ruby -v"

# Upgrade Rubygems, install Bundler, and rehash rbenv commands
# (this only needs to be done with the Bundler gem)
RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc
RUN bash --login -c "gem update --system && gem install bundler && rbenv rehash"

# Install Rails and Sidekiq
RUN bash --login -c "gem install sidekiq && gem install rails -v 4.2.6"

# Set entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

RUN git clone --depth 1 https://github.com/Netflix/Scumblr.git /app
WORKDIR /app
RUN bash --login -c "bundle install"
