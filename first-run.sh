#!/usr/bin/env sh

set -ex

generate_key() {
	dd if=/dev/urandom bs=1 count=16 | base64
}

SECRET_KEY=$(generate_key)
WEB_SECRET_KEY=$(generate_key)

cat > /var/botbot-grain-env < EOF
SECRET_KEY=$(generate_key)
WEB_SECRET_KEY=$(generate_key)
EOF

exec $(dirname $0)/launch.sh
