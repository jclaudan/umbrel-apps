#!/bin/bash

docker-compose pull && docker-compose build --pull && docker-compose push && docker-compose up -d || exit -1
