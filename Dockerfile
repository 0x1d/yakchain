FROM golang:1.16.2-buster as base

RUN apt update && \
    apt-get install -y \
        build-essential \
        ca-certificates \
        curl \
        make

WORKDIR /apps
COPY . .
RUN make install && mv /go/bin/yakchaind /usr/bin

# run chain as user
RUN useradd -ms /bin/bash yak
USER yak

# see docs for exposed ports:
#   https://docs.starport.network/kb/config.html#host
EXPOSE 26657
EXPOSE 26656
EXPOSE 6060 
EXPOSE 9090 
EXPOSE 1317 

ENTRYPOINT ["yakchaind", "start"]