#!/usr/bin/env bash

if [[ ! -d venv ]]; then
    python3 -m venv venv
fi

venv/bin/pip install -U pip
venv/bin/pip install wheel
venv/bin/pip install ansible-base jmespath

venv/bin/ansible-galaxy install -r requirements/requirements.yml
