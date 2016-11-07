#runs in background
for type in ecdsa rsa ed25519
do 
    ssh-keygen -t ${type} -f /etc/ssh/ssh_host_${type}_key -N ''
done
/usr/sbin/sshd

#runs in background
/usr/sbin/httpd

#create git projects if they dont already exist
su - git -c 'for proj in purebuild base; do /init_git_projs.sh $proj; done'

#runs in foreground
su - git -c 'git daemon --reuseaddr --enable=receive-pack --base-path=/var/www/html/git /var/www/html/git'
