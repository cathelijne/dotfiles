#!/bin/bash

function authentication () {
  auth=$(curl -X 'POST' \
    "$3/api/auth/token" \
    -H 'accept: application/json' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -d 'grant_type=&username='$1'&password='$2'&scope=&client_id=&client_secret=')

    echo $auth |  sed -e 's/.*token":"\(.*\)",.*/\1/'
}

function import_from_file () {
  while IFS= read -r line
  do
    echo $line
    curl -X 'POST' \
      "$3/api/recipes/create-url" \
      -H "Authorization: Bearer $2" \
      -H 'accept: application/json' \
      -H 'Content-Type: application/json' \
      -d '{"url": "'$line'" }'
    echo
  done < "$1"
}

input="list"
mail="mealie@hornstra.com"
password="1234hvhv"
mealie_url=https://recipes.pepperlink.nl


token=$(authentication $mail $password $mealie_url)
import_from_file $input $token $mealie_url
