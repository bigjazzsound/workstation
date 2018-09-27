FROM ubuntu:latest

RUN apt update -q && apt install -q -y sudo ansible git

ENTRYPOINT ["ansible-pull", "-K", "--accept-host-key", "-vvv", "-U", "https://github.com/bigjazzsound/workstation", "playbooks/main.yml"]
