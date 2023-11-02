#!/bin/bash

docker-compose build --pull && docker-compose push || exit -1
