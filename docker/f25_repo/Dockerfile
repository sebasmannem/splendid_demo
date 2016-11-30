FROM f25:ssh
RUN dnf install -y createrepo httpd git git-daemon python-dnf sudo iproute libsemanage-python gzip tar rpm-sign pinentry-gtk
COPY start.sh init_git_projs.sh /
RUN useradd git -d /var/lib/git
RUN chown git:git /var/lib/git
#RUN su - git -c 'for proj in purebuild base; do /init_git_projs.sh $proj; done'
CMD /start.sh

#to start it do something like this:
# docker -d repo:latest /bin/bash
