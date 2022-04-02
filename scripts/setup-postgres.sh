#!/usr/bin/env bash

set -euo pipefail

main() {
  echo "Generating 'authelia_storage_postgres_password' secret ..."
  touch ./secrets/postgres_default_password

  echo "Please enter a secret for 'postgres_default_password': "
  read -rs psql_secret
  printf "\n"

  echo "$psql_secret" > ./secrets/postgres_default_password

  echo "'postgres_default_password' file has been generated!"
  printf "\n"
}

main # Make it so.
