#!/bin/bash

source /etc/profile.d/rbenv.sh
exec 2>&1

BUNDLE_PATH=${BUNDLE_PATH:-/bundle}
SCUMBLR_USER=${SCUMBLR_USER:-admin@nowhere.com}
SCUMBLR_PASSWORD=${SCUMBLR_PASSWORD:-admin}

bundle exec rake db:create
bundle exec rake db:schema:load
bundle exec rails runner "User.where(email: '${SCUMBLR_USER}', admin: true).first_or_create(password: '${SCUMBLR_PASSWORD}', password_confirmation: '${SCUMBLR_PASSWORD}')"

exec bundle exec "$@"
