#!/usr/bin/env bash

set -euo pipefail

main() {
  echo "Generating 'plex_claim_token' secret ..."
  touch ./secrets/plex_claim_token

  echo "Please enter a token for 'plex_claim_token': "
  echo "  (Hint: Visit https://www.plex.tv/claim/)"
  read -rs token
  printf "\n"

  echo "$token" > ./secrets/plex_claim_token

  echo "'plex_claim_token' file has been generated!"
  printf "\n"

  echo "Done."
}

main # Make it so.
