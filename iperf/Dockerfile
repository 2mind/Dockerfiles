FROM alpine:3.2
MAINTAINER SHS

RUN apk update && \
    apk upgrade && \ 
    apk add iperf && \
    rm -rf /var/cache/apk/*
    
EXPOSE 5001 5001/UDP

ENTRYPOINT ["/usr/bin/iperf"]
CMD ["-s"]

