#! /bin/sh
# wait for postgres

set -e

host="$1"
shift
cmd="$@"

until PGPASSWORD=$PROSODY_POSTGRES_PASSWORD \
                  psql -h "$host" -U "$PROSODY_POSTGRES_USER" -d "$PROSODY_POSTGRES_USER" -c '\q'; do \
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec $cmd