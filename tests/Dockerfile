FROM fedora:latest

RUN dnf install -y sudo ansible

ENTRYPOINT ["ansible-playbook", "-vvv", "/srv/playbooks/main.yml"]
