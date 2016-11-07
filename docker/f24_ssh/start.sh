for type in ecdsa rsa ed25519
do 
    ssh-keygen -t ${type} -f /etc/ssh/ssh_host_${type}_key -N ''
done
/usr/sbin/sshd
#cat
#for docker run -ti, cat holds forever, but for docker run -d, cat gets no stdin and stops, stopping container.
#use this loop instead of cat, to hold forever. Of coarse, /bin/true could be any otehr test aswel, 
#giving you the options to end container without killing this script.
while /bin/true; do sleep 60; done
