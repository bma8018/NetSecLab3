DNS_enumeration.bat is a script that takes the input from file 'input_hostnames.txt', finds the address on the network to that hostname, and outputs the findings to file 'Addresses.txt'

The input file, 'input_hostnames.txt', needs each hostname to be on its own individual line.

The output file, 'Addresses.txt', will detail each hostname speciied to its IP address, or will state a hostname followed by a '%b', indicating that the IP address was not found to that hostname. 