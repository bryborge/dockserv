#!/usr/bin/env bash

set -euo pipefail

##
# Primary instructions.
#
main() {
  echo "Please enter a password for Redis."
  read -rs password

  generate_config "$password"
  generate_secret "$password"

  echo "Done."
}

##
# Generates the Redis configuration file.
#
generate_config() {
  pushd ./appdata/redis > /dev/null 2>&1

  echo "Generating Redis configuration file ..."
  cp redis.conf{.dist,}
  sed -i "s/<REQUIREPASS>/$1/" redis.conf

  popd > /dev/null 2>&1
}

##
# Generates the Redis secret.
#
generate_secret() {
  touch ./secrets/redis_default_password

  echo "Generating 'redis_default_password' secret ..."
  echo "$1" > ./secrets/redis_default_password

  echo "'redis_default_password' file has been generated!"
  printf "\n"

  echo "Done."
}

main # Make it so.
