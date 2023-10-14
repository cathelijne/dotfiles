# This script selects the 100 oldest entries from your Bitwarden vault
# and opens 10 random URIs from that list in your default browser.
# Keep your data safe and change passwords often!

bw list items|jq -r '. |
  (sort_by(.revisionDate) | reverse)[1:100][] |
  select(.login != null).login |
  select(.uris != null).uris[:1][] |
  ("open " + .uri)' |
  shuf | head -10 | sh
