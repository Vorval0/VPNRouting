curl --fail https://reestr.rublacklist.net/api/v3/ips/ | jq -r '.[]' | grep "\." | sed "s/\$/\/32/" | aggregate | awk '{print "ip route " $1 " wg0 auto"}' > /mnt/c/tmp/command.txt
