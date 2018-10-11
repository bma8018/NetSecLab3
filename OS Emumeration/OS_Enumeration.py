import subprocess

infile = file("machines.txt", 'r')
outfile = file("OS.txt", 'w')
for line in infile:
    line = line.strip()
    output = subprocess.check_output("ping -n 1 "+line)
    print output
    n = output.find("TTL=")
    n+=4
    output = output[n:]
    n = output.find("\r")
    ttl = output[:n]
    if int(ttl) <=64:
        outfile.write(line + "\tLinux Box\n")
    elif int(ttl) <=128:
        outfile.write(line + "\tWindows Box\n")
    else:
        outfile.write(line + "\tSolaris Box\n")

infile.close()
outfile.close()
