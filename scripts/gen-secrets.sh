#!/usr/bin/env bash

set -euo pipefail

SECRET_FILES=(
  'authelia_jwt_secret'
  'authelia_session_redis_password'
  'authelia_session_secret'
  'authelia_storage_encryption_key'
  'authelia_storage_postgres_password'
)

##
# The primary instruction loop.
#
main() {
  for f in ${SECRET_FILES[@]}; do
    ensure_secret_exists $f
  done

  echo "Finished."
}

##
# Check if the secret already exists. If it does, ask the user to either write
# over the secret or skip. If it doesn't, generate the secret.
#
ensure_secret_exists() {
  if [ `find ./secrets -maxdepth 1 -type f -name $1` ]; then
    echo "The secret '$1' already exists! Write over existing secret?"
    read -p "Enter [y/N]: " opt
    printf "\n"

    # if 'yes', delete existing secret and generate a new one.
    if [[ "y" == $opt || "Y" == $opt ]]; then
      rm ./secrets/$1
      echo "'$1' has been deleted."
      generate_secret $1
    # otherwise, skip.
    else
      echo "Keeping the existing '$1' secret."
    fi
  else
    generate_secret $1
  fi
}

##
# Generate a secret file.
#
generate_secret() {
  echo "Generating '$1' secret."
  touch ./secrets/$1

  echo "Please enter a secret for '$1': "
  read -rs secret
  printf "\n"

  echo $secret > ./secrets/$1

  echo "'$1' secret has been generated."
  printf "\n"
}

main # Make it so.
