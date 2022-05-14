#!/usr/bin/env bash

set -euo pipefail

main() {
  echo "Generating 'cloudflare_api_key' secret ..."
  touch ./secrets/cloudflare_api_key

  echo "Please enter an API key for 'cloudflare_api_key': "
  read -rp "  Key: " key
  printf "\n"

  echo "$key" > ./secrets/cloudflare_api_key

  echo "'cloudflare_api_key' file has been generated!"
  printf "\n"

  echo "Done."
}

main # Make it so.
