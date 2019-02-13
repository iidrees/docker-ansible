FROM ubuntu:trusty

# prevent dpkg errors
ENV TERM=xterm-256color

# set mirrors to NZ
RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list
 
# install Ansible
RUN apt-get update -qy && \
  apt-get install -qy software-properties-common && \
  apt-add-repository -y ppa:ansible/ansible && \
  apt-get update -qy && \
  apt-get install -qy ansible 

# Copy baked playbook
COPY ansible /ansible

# Add volume for ansible playbook

VOLUME /ansible
WORKDIR /ansible

# entrypoint 
ENTRYPOINT ["ansible-playbook"]

CMD ["site.yml"]