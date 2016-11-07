#Create docker image
cd docker/f24_ssh ; docker build --rm -t f24:ssh . ; cd -

#Cleanout known_hosts from previous deployments
sed -i /172.17.0/d /home/sabes/.ssh/known_hosts

#Create docker containers
for ((i=0;i<4;i++)); do docker run -d f24:ssh; done

#Checkout hostnames / ip adresses and add to every hosts /etc/hostname
./bash/docker_dns_hosts.sh
ssh -i docker/f24_ssh/id_rsa root@172.17.0.2
  vi /etc/hosts
    *Remove line for this host
    *Add output of ./bash/docker_dns_hosts.sh
    *Add hostname testbase.splendiddata.com to line for 172.17.0.2
Do same on other hosts (172.17.0.{3,4,5})but keep testbase.splendiddata.com linked to 172.17.0.2 on all).

#Change staging/inventory if needed
*Only needed for non default docker deployments, or with already running containers


#Run playbook all.yml, or repo.yml, then repmgr.yml and then barman.yml
*all.yml calls all the other playbooks in the correct order
*repo.yml initializes repo container
*repmgr.yml initializes database servers, making first server a master and the rest a standby (only one standby is tested for now)
*barman.yml initializes database servers as barman clients and barman server as barman server
cd ansible ; ansible-playbook all.yml -i staging/inventory -u root --private-key ../docker/f24_ssh/id_rsa ; cd -

#Cleanout docker containers
docker ps
docker kill [container1 id] [container2 id] [container3 id] [container4 id]
docker rm [container1 id] [container2 id] [container3 id] [container4 id]

#Cleanout known_hosts
*this will do the trick, but might break known hosts that need not be cleaned
sed -i /172.17.0/d /home/sabes/.ssh/known_hosts
*or do your own cleanout
