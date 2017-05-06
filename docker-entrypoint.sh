#!/bin/bash

source /etc/profile.d/rbenv.sh
exec 2>&1

exec /bin/bash --login -c "$@"
