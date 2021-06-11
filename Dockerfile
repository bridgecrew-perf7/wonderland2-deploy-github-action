FROM alpine:latest
RUN apk add curl openssh-client bash yq

RUN curl -sSLfo /usr/local/bin/wl https://downloads.jimdo-platform.net/wl/latest/wl_linux_amd64 && chmod +x /usr/local/bin/wl

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
