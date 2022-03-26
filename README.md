# DockServ

A centralized place to define, manage, and orchestrate home server applications behind a reverse proxy.
This project was heavily
influenced by
[this](https://www.smarthomebeginner.com/traefik-2-docker-tutorial/)
tutorial and
[this](https://github.com/htpcBeginner/docker-traefik)
project.

## Built With

*   [Docker](https://docs.docker.com/get-docker/) - Engine for building/containerizing applications
*   [Docker-Compose](https://docs.docker.com/compose/install/) - Container orchestration tool

## Getting Started

These instructions will walk you through the process of setting up this project on a live system.
The following assumes that you have direct (keyboard/monitor) or indirect (ssh) access to the live system you're 
deploying to.

### Prerequisites

*   A live system running [Ubuntu Server](https://ubuntu.com/download/server)
*   A router configured to forward ports `:80` and `:443` for the Public IP of the live system
*   A domain provided by [Cloudflare](https://www.cloudflare.com)
*   Docker
*   Docker Compose
*   Git

### Installing

1.  Clone the project and change into the project directory.

    ```shell
    git clone git@github.com:sonofborge/dockserv.git && cd dockserv
    ```

2.  Create a new `.env` file and add the values to the variables to fit your needs.

    ```shell
    cp .env{.dist,}
    ```

3.  Create the docker networks.

    ```shell
    docker network create reverse_proxy
    docker network create socket_proxy
    ```

4.  Spin up some or all of your server applications with docker-compose.

    ```shell
    # Example: specific individual applications
    docker-compose up socket_proxy -d
    docker-compose up traefik
    ```

    ```shell
    # Example: all applications
    docker-compose up -d
    ```

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
