FROM fedora:latest

RUN dnf install -y ansible

ENTRYPOINT ["ansible-playbook", "/srv/ansible/plays/highstate.yml"]
