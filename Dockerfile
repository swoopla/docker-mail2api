FROM alpine:latest

LABEL MAINTAINER "Swoopla <p.vibet@gmail.com>"

RUN apk --update add fetchmail openssl ca-certificates curl;

COPY ./scripts/mail2youtubedl.sh /usr/local/bin

RUN chmod +x /usr/local/bin/mail2youtubedl.sh

USER postmaster

ENV YOUTUBEDL_URL=http://youtube-dl:8080/youtube-dl/q

VOLUME ["/etc/fetchmailrc", "/var/spool/mail"]

CMD ["fetchmail", "-vvv", "--nosyslog", "--nodetach", "--pidfile", "/tmp/fetchmail.pid", "-f", "/etc/fetchmailrc"]

