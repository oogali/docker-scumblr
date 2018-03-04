#!/bin/bash

set -e

exec 2>&1

if [ -z "${SKIP_MIGRATIONS}" ]; then
  PGPASSWORD="${DB_PASSWORD}" psql -c "SELECT 'tasks'::regclass" -U "${DB_USERNAME}" -h "${DB_HOST}" -p "${DB_PORT}" "${DB_NAME}" >/dev/null || (
    rake db:create && \
      rake db:structure:load
  )
fi

exec "$@"
