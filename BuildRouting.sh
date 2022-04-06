set -e
set -o pipefail

curl --fail -s https://api.bgpview.io/ip/13.107.42.14 | jq '.data.prefixes[].asn.asn' | xargs -I % curl --fail -s https://api.bgpview.io/asn/%/prefixes | jq -r '.data.ipv4_prefixes[].prefix' | aggregate -q
