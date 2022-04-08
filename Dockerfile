FROM ghcr.io/kmmiles/fedora35-wsl
ENV WSL_DISTRO_NAME kmmdev
WORKDIR /provision/ansible

# re-install a few packages. some tools are missing setuid.
RUN set -ex; dnf reinstall -y \
  sudo \
  shadow-utils

#
RUN mkdir -p playbooks
COPY ./ansible/ansible.cfg ansible.cfg
COPY ./ansible/hosts hosts

#
COPY ./ansible/playbooks/install-base.yml playbooks
RUN set -ex; ansible-playbook playbooks/install-base.yml

#
COPY ./ansible/playbooks/install-dev.yml playbooks
RUN set -ex; ansible-playbook playbooks/install-dev.yml

#
COPY ./ansible/playbooks/install-home.yml playbooks
RUN set -ex; ansible-playbook playbooks/install-home.yml

# copy system files
COPY ./etc/wsl.conf /etc/wsl.conf

# handle shrinking image
ARG SHRINK
RUN set -ex; \
  if [[ "$SHRINK" == true ]]; then \
    dnf autoremove -y \
    dnf clean all -y \
    find /root -mindepth 1 -exec rm -rf {} \; \
    find /tmp -mindepth 1 -exec rm -rf {} \; \
    find /var/tmp -mindepth 1 -exec rm -rf {} \; \
    find /var/cache -type f -exec rm -rf {} \; \
    find /var/log -type f | while read -r f; do /bin/echo -ne "" > "$f"; done \
  fi
