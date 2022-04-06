set -e
set -o pipefail

echo $@ | \
xargs dig +noall +answer -t A | awk '{print $NF}' | \
xargs -I % curl --fail -s https://api.bgpview.io/ip/% | jq '.data.prefixes[].asn.asn' | \
sort -u | xargs -I % curl --fail -s https://api.bgpview.io/asn/%/prefixes | jq -r '.data.ipv4_prefixes[].prefix' | \
aggregate -q
