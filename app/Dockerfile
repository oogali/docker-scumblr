# Source from Idle Pattern's Ubuntu latest with rbenv
FROM idlepattern/ubuntu-rbenv
ARG RUBY_VERSION=2.0.0-p481
ENV RUBY_VERSION ${RUBY_VERSION}

# Install additional dependencies for Scumblr
RUN apt-get update && apt-get -y install autoconf bison libpq-dev libtool \
  libsqlite3-dev libcurl3 libmagickcore-dev libmagickwand-dev imagemagick

# Housekeeping/attribution
MAINTAINER "Omachonu Ogali" <oogali@idlepattern.com>

# Install and select the version of Ruby this project needs
RUN bash --login -c "rbenv install ${RUBY_VERSION}"
RUN bash --login -c "rbenv global ${RUBY_VERSION} && ruby -v"

# Upgrade Rubygems, install Bundler, and rehash rbenv commands
# (this only needs to be done with the Bundler gem)
RUN echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc
RUN bash --login -c "gem update --system"
RUN bash --login -c "gem install bundler && rbenv rehash"

# Checkout scumblr repo
RUN mkdir -p /apps && git clone https://github.com/Netflix/Scumblr.git /apps/scumblr

WORKDIR /apps/scumblr

# Set entrypoint
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# Install gems
ENV BUNDLE_PATH /bundle
RUN bash --login -c "bundle install"

# Launch server
EXPOSE 3000
CMD ['rails', 'server']
