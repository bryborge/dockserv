#!/usr/bin/env bash

set -euo pipefail

##
# Primary instructions.
#
main() {
  pushd ./appdata/authelia > /dev/null 2>&1
  generate_config_file
  generate_user_file
  popd > /dev/null 2>&1

  pushd ./traefik/rules > /dev/null 2>&1
  update_middlewares_rules
  popd > /dev/null 2>&1

  echo "Done."
}

##
# Generates the required Authelia configuration.yml file from the .dist
# template file.
#
generate_config_file() {
  echo "Generating Authelia configuration file ..."
  cp configuration.yml{.dist,}
  printf "\n"

  echo "Please enter your domain name. (ex: domain.com)"
  search_replace_prompt "Domain Name: " "<DOMAIN_NAME>" configuration.yml

  echo "Authelia configuration.yml file created!"
  printf "\n"
}

##
# Generates the required Authelia users.yml file from the .dist template file.
#
generate_user_file() {
  echo "Generating Authelia user file ..."
  cp users.yml{.dist,}
  printf "\n"

  echo "Please enter your user name."
  search_replace_prompt "User Name: " "<USER_NAME_HERE>" users.yml

  echo "Please enter your email."
  search_replace_prompt "Email: " "<EMAIL_ADDRESS_HERE>" users.yml

  echo "Please enter your argon2id hash."
  search_replace_prompt "Argon2id Hash: " "<ARGON2ID_HASHED_PASSWORD_HERE>" users.yml

  echo "Authelia user.yml file created!"
  printf "\n"
}

update_middlewares_rules() {
  echo "Altering Authelia middlewares rules file ..."
  printf "\n"

  echo "Please enter your domain name (again). (ex: domain.com)"
  search_replace_prompt "Domain Name: " "<DOMAIN_NAME>" web-middlewares.yml
  echo "Authelia middlewares rules updated!"
  printf "\n"
}

##
# Helper function to a) prompt the user for a value, then search/replace that
# value in a given file.
#
# Example:
# --------
# search_replace_prompt "Prompt: " "string-to-replace-with-prompt-value" filename.txt
#
search_replace_prompt() {
  read -p "$1" opt
  # using ':' delimiter due to argon2id using /'s and ='s
  sed -i "s:$2:$opt:" $3
  printf "\n"
}

main # Make it so.