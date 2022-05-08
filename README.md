<div align="center">
  <br />
  <h1 align="center">DockServ</h1>
  <p align="center">
    A centralized place to define, manage, and orchestrate home server applications behind a reverse proxy.
    <br />
    <br />
    <a href="https://github.com/sonofborge/dockserv"><strong>Explore the docs »</strong></a>
  </p>
  <br />
</div>

## Table of Contents

<details>
  <summary>Show/Hide</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li>
          <a href="#prerequisites">Prerequisites</a>
        </li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li>
      <a href="#license">License</a>
    </li>
  </ol>
</details>
<br />

## About the Project

DockServ is a stack of containerized open-source web applications served behind a reverse proxy service.

This project was heavily
influenced by
[this](https://www.smarthomebeginner.com/traefik-2-docker-tutorial/)
tutorial and
[this](https://github.com/htpcBeginner/docker-traefik)
project.

### Built With

*   [Docker](https://docs.docker.com/get-docker/) - Engine for building/containerizing applications.
*   [Traefik Proxy](https://doc.traefik.io/traefik/) - Edge Router that makes publishing your services a fun and easy experience.

## Getting Started

These instructions will walk you through the process of setting up this project on a live system.
The following assumes that you have direct (keyboard/monitor) or indirect (ssh) access to the live system you're 
deploying to.

### Prerequisites

*   A live system running a linux distribution (like [Ubuntu Server](https://ubuntu.com/download/server))
*   A router configured to forward ports `:80`, `:443`, and `:32400` of the live system
*   A web domain provided by [Cloudflare](https://www.cloudflare.com)
*   Docker
*   Git

### Installation

1.  Clone the project and change into the project directory.

    ```shell
    git clone git@github.com:sonofborge/dockserv.git && cd dockserv
    ```

2.  Create a new `.env` file and edit the environment variable values to suit your configuration.

    ```shell
    cp .env{.dist,}
    ```

3.  Run the Authelia setup script and follow the on-screen instructions.

    ```shell
    bash scripts/setup-authelia.sh
    ```

4.  Run the Redis setup script and follow the on-screen instructions.

    ```shell
    bash scripts/setup-redis.sh
    ```

5.  Run the Postgres setup script and follow the on-screen instructions.

    ```shell
    bash scripts/setup-postgres.sh
    ```

6.  Spin up some or all of your server applications with `docker compose`.

    ```shell
    # Example: specific individual applications
    docker compose up socket_proxy -d
    docker compose up traefik
    ```

    ```shell
    # Example: all applications
    docker compose up -d
    ```

7.  If you're logging into Authelia for the first time, you'll need to setup totp.
    After you've added your credentials, click on "Not registered yet?" and follow the instructions to register another
    device for authorization.
    The email it sends can be found in `appdata/authelia/notification.txt`.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
