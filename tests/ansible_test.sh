#!/usr/bin/env bash

docker build -t ansible_test_image .
docker run -v /srv:/srv:Z ansible_test_image
