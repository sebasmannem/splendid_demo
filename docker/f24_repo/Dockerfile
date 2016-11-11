FROM f24:ssh
RUN dnf update -y
RUN dnf install -y createrepo httpd git git-daemon gzip tar
COPY start.sh init_git_projs.sh /
RUN useradd git -d /var/lib/git
RUN chown git:git /var/lib/git
CMD /start.sh

#to start it do something like this:
# docker -d f24:repo
