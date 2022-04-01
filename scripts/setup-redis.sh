#!/usr/bin/env bash

set -euo pipefail

##
# Primary instructions.
#
main() {
  echo "Please enter a password for Redis."
  read -rs "  Password: " password

  generate_config $password
  generate_secret $password

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
# Generates the Redis secret file.
#
generate_secret() {
  pushd ./secrets > /dev/null 2>&1

  echo "Generating Redis Secret file ..."
  echo $1 > authelia_session_redis_password

  popd > /dev/null 2>&1
}

main # Make it so.
