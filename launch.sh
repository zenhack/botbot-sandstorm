#!/usr/bin/env sh

set -ex

venv=/app/.venv
. $venv/bin/activate
cd $venv/src/botbot

export PGDATA="/var/lib/postgres/data"

generate_key() {
	dd if=/dev/urandom bs=1 count=16 | base64
}

case $1 in
	firstrun)
		cat > /var/botbot-grain-env <<EOF
export SECRET_KEY=$(generate_key)
export WEB_SECRET_KEY=$(generate_key)
EOF

		initdb -D $PGDATA
		createdb botbot
		echo 'create extension hstore' | psql botbot
	;;
	restart) : ;;
	*)
		printf 'Error: unknown argument %s\n' "$1"
		exit 1
	;;
esac

. .env

redis-server &
postgres &
python manage.py migrate

case $1 in
	firstrun) python manage.py createsuperuser ;;
	restart) : ;;
	*)
		printf 'Error: unknown argument %s\n' "$1"
		exit 1
	;;
esac

python manage.py run_plugins &
botbot-bot
