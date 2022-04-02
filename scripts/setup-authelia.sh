#!/usr/bin/env bash

set -euo pipefail

##
# Primary instructions.
#
main() {
  echo "Please enter your domain name. (ex: domain.com)"
  read -rp "  Domain: " domain

  generate_traefik_middlewares "$domain"
  generate_config "$domain"
  generate_secrets
  generate_postgres_password
  generate_redis_password

  echo "Done."
}

generate_traefik_middlewares() {
  pushd ./appdata/traefik/rules > /dev/null 2>&1

  echo "Generating Traefik middlewares ..."
  cp web-middlewares.yml{.dist,}
  sed -i "s/<DOMAIN_NAME>/$1/" web-middlewares.yml

  popd > /dev/null 2>&1
}

generate_config() {
  pushd ./appdata/authelia > /dev/null 2>&1

  echo "Generating Authelia configuration file ..."
  cp configuration.yml{.dist,}
  sed -i "s/<DOMAIN_NAME>/$1/" configuration.yml

  echo "Generating Authelia users file ..."
  cp users.yml{.dist,}

  echo "Please enter your user name."
  read -rp "  User Name: " uname
  sed -i "s/<USER_NAME_HERE>/$uname/" users.yml

  echo "Please enter your user email."
  read -rp "  Email: " uemail
  sed -i "s/<EMAIL_ADDRESS_HERE>/$uemail/" users.yml

  echo "Please enter your argon2id hash."
  echo "  (Hint: docker run authelia/authelia:latest authelia hash-password '<password>')"
  read -rp "  Argon2id Hash: " uhash
  sed -i "s/<ARGON2ID_HASHED_PASSWORD_HERE>/$uhash/" users.yml

  popd > /dev/null 2>&1
}

generate_secrets() {
  local secret_files=(
    'authelia_jwt_secret'
    'authelia_session_secret'
    'authelia_storage_encryption_key'
  )

  for f in "${secret_files[@]}"; do
    echo "Generating '$f' secret ..."
    touch ./secrets/"$f"

    echo "Please enter a secret for '$f': "
    read -rs secret
    printf "\n"

    echo "$secret" > ./secrets/"$f"
    echo "'$f' file has been generated!"
    printf "\n"
  done
}

generate_postgres_password() {
  echo "Generating 'authelia_storage_postgres_password' secret ..."
  touch ./secrets/authelia_storage_postgres_password

  echo "Please enter a secret for 'authelia_storage_postgres_password': "
  read -rs psql_secret
  printf "\n"

  echo "$psql_secret" > ./secrets/authelia_storage_postgres_password
  cp ./appdata/postgres/initdb.d/authelia-user-db.sh{.dist,}
  sed -i "s/<AUTHELIA_PASSWORD>/$secret/" ./appdata/postgres/initdb.d/authelia-user-db.sh

  echo "'authelia_storage_postgres_password' file has been generated!"
  printf "\n"
}

generate_redis_password() {
  echo "Generating Redis Secret file ..."
  echo "Please enter a secret for 'authelia_session_redis_password': "
  read -rs redis_secret
  printf "\n"

  echo "$redis_secret" > ./secrets/authelia_session_redis_password

  echo "'authelia_session_redis_password' file has been generated!"
  printf "\n"
}

main # Make it so.
