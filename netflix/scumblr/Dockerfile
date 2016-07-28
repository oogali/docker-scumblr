# Source from Idle Pattern's Ubuntu 14.x with rbenv
FROM idlepattern/ubuntu-14-rbenv
ARG RUBY_VERSION=2.0.0-p481
ENV RUBY_VERSION ${RUBY_VERSION}

# Install additional dependencies for Scumblr
RUN apt-get update && apt-get -y install autoconf bison libpq-dev libtool \
  libsqlite3-dev libcurl3 libmagickcore-dev libmagickwand-dev imagemagick

# Housekeeping/attribution
MAINTAINER "Omachonu Ogali" <oogali@idlepattern.com>
ENV container docker

# Install and select the version of Ruby this project needs
ENV CONFIGURE_OPTS --disable-install-doc
RUN bash --login -c "rbenv install ${RUBY_VERSION}"
RUN bash --login -c "rbenv global ${RUBY_VERSION} && ruby -v"

# Install Bundler, and rehash rbenv commands (this only needs to be done with the Bundler gem)
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN bash --login -c "gem install bundler && rbenv rehash"

# Checkout scumblr repo
RUN mkdir -p /apps && git clone https://github.com/Netflix/Scumblr.git /apps/scumblr

WORKDIR /apps/scumblr

# Install gems and initialize database
RUN bash --login -c "bundle install"
RUN bash --login -c "rake db:create && rake db:schema:load"

# Launch server
EXPOSE 3000
CMD bash --login -c "bundle exec rails server"
