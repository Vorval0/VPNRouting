curl --fail https://reestr.rublacklist.net/api/v3/ips/ | jq -r '.[]' | grep "\." | sed "s/\$/\/32/" | aggregate | awk '{print "ip route " $1 " wg0 auto"}' | sed "s/\/32//" > /mnt/c/tmp/command.txt
