FROM ubuntu:latest

RUN dpkg --add-architecture i386 && \
            apt update -q && \
            apt install -q -y git python3-pip sudo && \
            python3 -m pip install ansible

ENTRYPOINT ["ansible-pull", "-U", "https://github.com/bigjazzsound/workstation", "-l", "local", "--accept-host-key", "playbooks/main.yml"]
