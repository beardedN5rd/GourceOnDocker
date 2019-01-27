# GourceOnDocker
Run [Gource](https://gource.io/) inside docker containers, atm it does not utilize a 3D graphic card to be more portable. Since gource is only wrapped into a container, you may change the scripts to your needs easily.

## Quickstart

On the host machine only docker is required, than run:

* `fetch` the dependencies
* `build` the docker image
* `run` the container, pass the Directory inside which you repos reside with `-d <dir name>`
