#!/bin/bash

set -e

exec 2>&1

if [ -z "${SKIP_MIGRATIONS}" ]; then
  psql -c "SELECT 1 FROM tasks LIMIT 1;" -U "${DB_USERNAME}" --no-password -h "${DB_HOST}" -p "${DB_PORT}" "${DB_NAME}" >/dev/null || (
    rake db:create && \
      rake db:structure:load
  )
fi

exec "$@"
