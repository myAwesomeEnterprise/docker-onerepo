## Requirements

## Installation

- Clone repo
    ```bash
    git clone --recurse-submodules https://github.com/myAwesomeEnterprise/docker-onerepo.git
    ```

## Add new submodules

For add new git submodules to this project you must run this command (${PATH_NAME} is optional, default is repo name):
```shell
    $ cd services
    $ git submodules add -f ${REPO_URL} ${PATH_NAME}
```