#docker build --rm -t centos7_ssh .
#docker run -id centos7_ssh
#docker inspect [new container]
#ssh [inspect>NetworkSettings>IPAddres]

FROM fedora:24
#Added yum, gzip, tar, python-dnf, sudo, iproute, and libsemanage-python for ansible stuff to work properly
RUN dnf -y update
RUN dnf -y install openssh-server openssh-clients python-dnf sudo iproute libsemanage-python gzip tar yum python2-dnf
COPY start.sh /start.sh
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chown -R root:root /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys
CMD /bin/bash /start.sh
