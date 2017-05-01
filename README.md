# General

This git repository holds anything needed to give a demo of SplendidData Postgres Pure.
Basic aproach is that you
* create a docker image of fedora or centos
* use that image to spin 4 docker containers
* use ansible to 
  * configure one as a repo and 
  * install postgres, repmgr and barman from that repo

# Step by step

## Start the docker containers

```bash
docker-compose up -d
```

## Change default config if needed

Only needed for 
* non default docker deployments, or with already running containers
* switching between centos / fedora (default is centos)
* switching to pure3 (default is pure4)
Look at 
* ansible/group_vars/all for all preconfigured variables
* ansible/staging/inventory for all hostrelated stuff

# Run playbook all.yml, or repo.yml, then repmgr.yml and then barman.yml

* all.yml calls all the other playbooks in the correct order
* repo.yml initializes repo container
* repmgr.yml initializes database servers, making first server a master and the rest a standby (only one standby is tested for now)
* barman.yml initializes database servers as barman clients and barman server as barman server

```bash
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ansible/all.yml -i ansible/staging/inventory -u root --private-key docker/c7_ssh/id_rsa
```

# Cleanup

## Cleanout docker containers

* `docker-compose kill`
* `docker-compose rm`
