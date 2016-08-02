Docker container with samba, ldap backend and syslog forwarding
Based on Ubuntu with a size of 190MB

NOTE: Example assumes you have a "/samba" with your container specific data!
Change as needed with the SRC data that you are mounting into the container.
Example named data is defined in the example subdir.

## Required "DATA" directory - named.conf and zone data:
This container assumes you have a "/samba" folder with your container specific data:
You can change that folder as needed, but make sure you update the "-v" mounts for run time

1.) [ *REQUIRED* ] In your /samba/etc/samba a file "smb.conf", which acts as an entry point to your config

2.) [ *REQUIRED* ] A "/samba/var/lib/samba" directory for the Samba database

3.) [ *REQUIRED* ] A "/samba/etc/ldap.conf" file for the ldap config

4.) [ *OPTIONAL* ] set environment variable "UDPLOGHOST" or "TCPLOGHOST", if defined rsyslog will be started with remote SYSLOG logging to these hosts. If you use remote syslog, then it might be useful to set the hostname of the container depending on your server syslog configuration (the logs on the syslog server might get stored based on the hostname of the client)


## Run samba

```
docker run --name=sambaserver --hostname=sambaserver --rm -p 137:137/udp -p 138:138/udp -p 139:139 -p 445:445 -e UDPLOGHOST=192.168.0.17  -v /samba/var/lib/samba:/var/lib/samba  -v /samba/etc/samba:/etc/samba -v /samba:/etc/ldap.conf:/etc/ldap.conf qindel/samba-syslog
```