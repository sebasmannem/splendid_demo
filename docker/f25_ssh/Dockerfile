#docker build --rm -t centos7_ssh .
#docker run -id centos7_ssh
#docker inspect [new container]
#ssh [inspect>NetworkSettings>IPAddres]

FROM fedora:25
#sudo and iproute for ansible readyness
#python2-dnf (will pull python2 as requirement) for using with python2 instead of python3 (if you want to).
#htop grep procps-ng for ps and top to work
RUN dnf -y update
RUN dnf -y install openssh-server openssh-clients sudo iproute python2-dnf htop grep procps-ng
COPY start.sh /start.sh
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chown -R root:root /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys
CMD /bin/bash /start.sh
