#!/bin/sh

if [ -z "$BW_SESSION" ]; then
    echo "No Bitwarden session found. Run "bwu" to get a session id"
    bwu
fi
echo "$(bw get password ${ANSIBLE_VAULT_BW_ID} --session ${BW_SESSION} --raw)"
