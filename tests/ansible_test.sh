#!/usr/bin/env bash

if [[ -z $1 ]]; then
    echo -e "Usage:"
    echo -e "\t./ansible_test.sh ubuntu"
    echo -e "\t./ansible_test.sh fedora"
else
    type="$1"
    cd $type
    docker build -t ansible_test_image .
    docker run -v /srv:/srv:Z ansible_test_image
fi

