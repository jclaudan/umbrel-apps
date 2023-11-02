FROM ubuntu
RUN set Europe/Berlin timezone
RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN apt update && \
    apt install -y software-properties-common && \
    apt-add-repository ppa:git-core/ppa && \
    apt update && \
    apt install -y openssh-server git vim bash-completion
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "root:Passw0rd" | chpasswd
ENTRYPOINT service ssh start && bash -c 'while true; do sleep 30; done;'
RUN git config --global init.defaultBranch main && \
    git config --global user.email "max.mustermann@example.com" && \
    git config --global user.name "Max Mustermann"
COPY bashrc /tmp/bashrc
RUN cat /tmp/bashrc >> /root/.bashrc && \
    rm /tmp/bashrc
