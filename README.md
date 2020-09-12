# README

## Kubernetes-based development

Requirements:

- Virtualization enabled
  - On Mac - [hyperkit](https://minikube.sigs.k8s.io/docs/drivers/hyperkit/)
  - On Linux -  [kvm2](https://minikube.sigs.k8s.io/docs/drivers/kvm2/)

- [minikube](https://minikube.sigs.k8s.io/docs/)
- [skaffold](https://skaffold.dev/)

Run in the terminal `./bootstrap.sh` and it sets up minikube with the designated 
RAM and CPU allocation, skaffold config + adds entries to `/etc/hosts`.

Next step and this must be done every time when you launch a new shell: You have to 
run:

* Bash/Zsh

`eval $(minikube docker-env)`

* Fish

`minikube docker-env | source`

* Other shells

With `minikube docker-env` you will have at the end a specified command for your shell 


Finally: `skaffold dev --force=true`

It will create a docker image for the source code and watch for changes and sync (not rebuild) the images for ruby files. If you append
for example new gems to Gemfile, it will rebuild in order to run bundler. We need `force ` flag for recreating 
kubernetes resources if necessary for deployment

## Docker-compose based development

Requirements:

- [Docker](https://www.docker.com/)
- [Docker compose](https://docs.docker.com/compose/)

There are 3 files exposed: 

* docker-compose.yml

This provides full experience with docker with running app + migration and database.
In order to start, type: 

`docker-compose up`

* docker-compose-test.yml

This just runs the tests with a slightly tweaked configuration of database in order 
to make the tests run faster. There is a script inside `bin` folder for easier invocation.

`bin/test.sh`

## Ruby version

2.7.1