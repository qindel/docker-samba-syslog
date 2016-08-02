FROM ubuntu:16.04
EXPOSE 137/udp 138/udp 139 445

ENV UDPLOGHOST=
ENV TCPLOGHOST=
# The rsyslog package for alpine has no omrelp support
#ENV RELPLOGHOST=

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qy libnss-ldap samba rsyslog

RUN mkdir -m 0755 -p /var/spool/rsyslog  && chown -R syslog:syslog /var/spool/rsyslog 

RUN mkdir -m 0755 -p /etc/samba /var/lib/samba /var/run/samba
RUN rm -f /etc/ldap.conf
COPY nsswitch.conf /etc/nsswitch.conf
# Mounts
# NOTE: Per Dockerfile manual -->
#	"if any build steps change the data within the volume
# 	 after it has been declared, those changes will be discarded."
VOLUME ["/var/spool/rsyslog"]
VOLUME ["/etc/rsyslog"]
VOLUME ["/etc/samba"]
VOLUME ["/etc/ldap.conf"]
VOLUME ["/var/lib/samba"]
VOLUME ["/home"]

COPY entrypoint.sh /
COPY rsyslog.conf /etc/rsyslog.conf

ENTRYPOINT ["/entrypoint.sh"]
