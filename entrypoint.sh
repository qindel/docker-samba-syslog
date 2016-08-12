#!/bin/sh
mkdir -p /etc/rsyslog
cat /dev/null > /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" ] && echo "*.* @$UDPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$TCPLOGHOST" ] && echo "*.* @@$TCPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" -o -n "$TCPLOGHOST" ] && /usr/sbin/rsyslogd -f /etc/rsyslog.conf
/usr/sbin/nmbd -D
sleep 1
exec /usr/sbin/smbd -F
