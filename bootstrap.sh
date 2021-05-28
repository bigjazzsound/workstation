#!/usr/bin/env bash

[[ ! -d venv ]] && python3 -m venv venv

venv/bin/pip install -U pip wheel
venv/bin/pip install ansible-base jmespath

venv/bin/ansible-galaxy install -r requirements.yml
