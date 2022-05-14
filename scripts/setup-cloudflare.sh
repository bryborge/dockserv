#!/usr/bin/env bash

set -euo pipefail

main() {
  echo "Generating 'cloudflare_email' secret ..."
  touch ./secrets/cloudflare_email

  echo "Please enter an email for 'cloudflare_email': "
  read -rp "  Email: " email
  printf "\n"

  echo "$email" > ./secrets/cloudflare_email

  echo "'cloudflare_email' file has been generated!"
  printf "\n"

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
