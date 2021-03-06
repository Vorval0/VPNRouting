set -e
set -o pipefail

echo $@ | \
xargs --no-run-if-empty --max-args=1 host -t A | awk '/has address/ { print $4 }' | cut -d '.' -f 1-3 | sort -u | \
xargs -I % curl --fail -s https://api.bgpview.io/ip/%.1 | jq '.data.prefixes[].asn.asn' | sort -u | \
xargs -I % curl --fail -s https://api.bgpview.io/asn/%/prefixes | jq -r '.data.ipv4_prefixes[] | select(.country_code != "RU") | .prefix' | \
aggregate -q
