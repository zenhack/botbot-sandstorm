# Start with a base image, for things needed both at runtime and build time.
FROM zenhack/sandstorm-http-bridge:238 as common
RUN apk add \
	python2 \
	build-base \
	py2-virtualenv

# The build environment; includes Go compiler, dev tools...
FROM common as build
RUN apk add \
	git \
	go \
	python2-dev \
	postgresql-dev \
	curl \
	npm

RUN npm install -g \
	'less@<1.4' \
	jshint

WORKDIR /app

RUN virtualenv .venv
RUN . .venv/bin/activate && \
	pip install -e git+https://github.com/BotBotMe/botbot-web.git#egg=botbot

# Override some settings in botbot's Makefile:
COPY ./make.config .venv/src/botbot/

# We need to adjust some versions in the requirements.txt:
#
# * psycopg2 is too old to work with postgresql 10.x
COPY ./requirements.patch .venv/src/botbot/
RUN cd .venv/src/botbot && \
	patch -p1 < requirements.patch

RUN . .venv/bin/activate && \
	cd .venv/src/botbot && \
	make dependencies

COPY ./env .venv/src/botbot/.env

COPY ./launch.sh /app/

# Delete the histories for repos we've cloned; these take up a non-trivial
# amount of space:
RUN find /app -type d -name .git | xargs rm -rf

# The final image. No dev tools, but includes db servers/everything needed at
# runtime...
FROM common
RUN apk add \
	redis \
	postgresql
COPY --from=build /app /app
