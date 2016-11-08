#General
This git repository holds anything needed to give a demo of SplendidData Postgres Pure.
Basic aproach is that you
* create a docker image of fedora or centos
* use that image to spin 4 docker containers
* use ansible to 
** configure one as a repo and 
** install postgres, repmgr and barman from that repo

#Step by step
##Create docker image
For fedora/24:
  cd docker/f24_ssh ; docker build --rm -t f24:ssh . ; cd -
For centos/7:
  cd docker/c7_ssh ; docker build --rm -t c7:ssh . ; cd -

##Create the docker containers
For fedora/24:
  for ((i=0;i<4;i++)); do docker run -d f24:ssh; done
For centos/7:
  for ((i=0;i<4;i++)); do docker run -d c7:ssh; done

##Cleanout known_hosts (to prevent ssh issues)
*For normal deployments, this will do the trick, but might break other known hosts that need not be cleaned
sed -i /172.17.0/d /home/sabes/.ssh/known_hosts
*So really think this through, create your own sed, do it by hand, or whatever...

##Set up DNS
This is a bruteforce fix and should better be replaced by an ansible play, but for now:
Checkout hostnames / ip adresses and add to every hosts /etc/hostname
./bash/docker_dns_hosts.sh
connect to the hosts and put output in /etc/hosts
ssh -i docker/f24_ssh/id_rsa root@172.17.0.2
  vi /etc/hosts
    *Remove line for this host
    *Add output of ./bash/docker_dns_hosts.sh
    *Add hostname testbase.splendiddata.com to line for 172.17.0.2
Do same on other hosts (172.17.0.{3,4,5}), but keep testbase.splendiddata.com linked to 172.17.0.2 on all).

##Change default config if needed needed
Only needed for 
* non default docker deployments, or with already running containers
* switching between centos / fedora (default is centos)
* switching to pure3 (default is pure4)
Look at 
* ansible/group_vars/all for all preconfigured variables
* ansible/staging/inventory for all hostrelated stuff

#Run playbook all.yml, or repo.yml, then repmgr.yml and then barman.yml
*all.yml calls all the other playbooks in the correct order
*repo.yml initializes repo container
*repmgr.yml initializes database servers, making first server a master and the rest a standby (only one standby is tested for now)
*barman.yml initializes database servers as barman clients and barman server as barman server
cd ansible ; ansible-playbook all.yml -i staging/inventory -u root --private-key ../docker/f24_ssh/id_rsa ; cd -

#Cleanup
##Cleanout docker containers
docker ps
docker kill [container1 id] [container2 id] [container3 id] [container4 id]
docker rm [container1 id] [container2 id] [container3 id] [container4 id]

##Cleanout known_hosts
*this will do the trick, but might break known hosts that need not be cleaned
sed -i /172.17.0/d /home/sabes/.ssh/known_hosts
*or do your own cleanout
