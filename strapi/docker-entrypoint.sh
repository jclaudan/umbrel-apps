#!/bin/sh
set -ea

if [ "$1" = "strapi" ]; then

  if [ ! -f "package.json" ]; then
    # Environement variable "DATABASE_CLIENT"
    # must be define in ".env".
    # it is posible to set "sqlite" for fast start
    DATABASE_CLIENT=${DATABASE_CLIENT}

    EXTRA_ARGS=${EXTRA_ARGS}

    echo "Using strapi $(strapi version)"
    echo "No project found at /srv/app. Creating a new strapi project"

    DOCKER=true strapi new . \
      --dbclient=$DATABASE_CLIENT \
      --dbhost=$DATABASE_HOST \
      --dbport=$DATABASE_PORT \
      --dbname=$DATABASE_NAME \
      --dbusername=$DATABASE_USERNAME \
      --dbpassword=$DATABASE_PASSWORD \
      --dbssl=$DATABASE_SSL \
      $EXTRA_ARGS

  elif [ ! -d "node_modules" ] || [ ! "$(ls -qAL node_modules 2>/dev/null)" ]; then

    echo "Node modules not installed. Installing..."

    if [ -f "yarn.lock" ]; then

      yarn install

    else

      npm install

    fi

  fi

fi

# CONFIG_DUMP_DIRECTORY_PATH = "/srv/config-dumps-files"
# APP_DIRECTORY_PATH = "/srv/app"

if [ -d "/srv/config-dumps-files" ]; then

  if [ ! -f "/srv/config-dumps-files/$DUMP_VERSION-dump-file.json" ]; then
    strapi configuration:dump -f /srv/config-dumps-files/$DUMP_VERSION-dump-file.json
  else
    strapi configuration:restore -f /srv/config-dumps-files/$DUMP_VERSION-dump-file.json
  fi

else

  mkdir /srv/config-dumps-files

fi

if [ -f "/srv/config-dumps-files/$DUMP_VERSION-dump-file.json" ]; then

  echo "Using dump file /srv/config-dumps-files/$DUMP_VERSION-dump-file.json"

else

  echo "No dump file found. Creating a new dump file"

  strapi configuration:dump -f /srv/config-dumps-files/$DUMP_VERSION-dump-file.json

fi

if ["$NODE_ENV" = "production"]; then
  if [! -f "/srv/app/ecosystem.config.js"]; then
    echo "[ENVIRONEMENT: $NODE_ENV ] VALUE OF DUMP_VERSION: [ $DUMP_VERSION ]"
    echo "No ecosystem.config.js found. Run `pm2 init`"
    if [ -f "/srv/config-dumps-files/ecosystem.config.js"]; then
      echo "Copy /srv/config-dumps-files/ecosystem.config.js TO /srv/app/ecosystem.config.js"
      cp /srv/config-dumps-files/ecosystem.config.js /srv/app/ecosystem.config.js
      echo "Copy Finished"
    else
      echo "No ecosystem.config.js found. Run `pm2 init` manualy"
    fi
  fi

  if [! -f "/srv/app/strapiloader.js"]; then
    if [ -f "/srv/config-dumps-files/strapiloader.js"]; then
      echo "Copy /srv/config-dumps-files/strapiloader.js TO /srv/app/strapiloader.js"
      cp /srv/config-dumps-files/strapiloader.js /srv/app/strapiloader.js
      echo "Copy Finished"
    else
      echo "No strapiloader.js found. Create it manualy"
    fi
  fi
fi

echo "Starting your app..."

exec "$@"
