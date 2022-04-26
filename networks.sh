set -e
set -o pipefail

echo $@ | \
xargs --no-run-if-empty --max-args=1 host -t A | awk '/has address/ { print $4 }' | \
xargs -I % curl --fail -s https://api.bgpview.io/ip/% | jq '.data.prefixes[].asn | select(.country_code != "RU") | .asn' | \
sort -u | xargs -I % curl --fail -s https://api.bgpview.io/asn/%/prefixes | jq -r '.data.ipv4_prefixes[].prefix' | \
aggregate -q
