#!/bin/bash

# Stops the execution of a script in case of error
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Verify if the DB exist or Not
echo -n "Establishing DB Connection.." ; until ss -tunlp | grep 0.0.0.0:5432 >/dev/null ; do sleep 1s; echo -n "." ;done; echo -en "..Done!\n"
sleep 10s
set +e; isExist=$(psql -lqt --host=$DATABASE_HOST --username=$DATABASE_USER | awk '{print $1}' | grep "api_gateway_*"); set -e
if [[ ! $isExist ]]; then 
  rake db:prepare 
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
