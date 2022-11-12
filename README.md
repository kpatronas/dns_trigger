# dns_track.sh
A simple script that will perform DNS queries vs a domain and if there is a change between script runs will print them on screen

## OPTIONS

* -d|--domain: domain name to check
* -n|--nameserver: nameserver to query
* -b|--basepath: where to save files between runs, defaults: ~/dns_track
* -t|--type: Type of DNS query, defaults: ANY
```
./dns_track.sh -d google.com -n 8.8.8.8
1,2c1,2
< A,142.250.184.206
< AAAA,2a00:1450:4001:830::200e
---
> A,142.250.181.238
> AAAA,2a00:1450:4001:82f::200e
```
## How to combine this with the mail command
```
./dns_track.sh -d google.com -n 8.8.8.8 | mail -s "Detected DNS record change for google.com" -E mail@example.com
```
* -E option for the mail command sends email only when input from stdin exists
