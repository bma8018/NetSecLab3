DNS_enumeration.bat is a script that takes the input from file 'input_hostnames.txt', finds the address on the network to that hostname, and outputs the findings to file 'Addresses.txt'

The input file, 'input_hostnames.txt', needs each hostname to be on its own individual line.

The output file, 'Addresses.txt', will detail each hostname, first to its DNS server, then to its IP address.

When the specified host has an IPv6 address, the IPv6 address will appear in the 'Addresses.txt' file instead of the IPv4 address.