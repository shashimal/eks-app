#!/usr/bin/env bash

generate_random_password(){
  local length="${1:-30}"

#  You can fine tune the excluded characters
  aws secretsmanager get-random-password --password-length "${length}" --no-include-space --exclude-characters "{#\@\"\`'^&(/)%:;<>,_?}!$" --require-each-included-type --output text
}

update_credential_in_secretsmanager() {
  local secret_id=${1}
  local password=${2}

  aws secretsmanager put-secret-value --secret-id "${secret_id}" --secret-string "${password}" 1> /dev/null
}

rotate_rds_master_password() {
  local cluster_id="${1}"
  local secret_id=${2}
  local length=${3:-}

  local new_password
  new_password=$(generate_random_password "${length}")

  update_credential_in_secretsmanager "${secret_id}" "${new_password}"

  aws rds modify-db-instance --db-instance-identifier "${db_instance_identifier}" --master-user-password "${new_password}" --apply-immediately 1> /dev/null
}

rotate_rds_master_password "$@"