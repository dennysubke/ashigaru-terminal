# syntax=docker/dockerfile:1.6
FROM ubuntu:22.04

ARG ASHI_VERSION=1.0.0
ARG ICON_URL="https://raw.githubusercontent.com/dennysubke/ashigaru-terminal/refs/heads/main/public/icon.png"
ARG TARGETARCH

LABEL org.opencontainers.image.title="Ashigaru Terminal (Docker Version)" \
      org.opencontainers.image.description="A Docker-based, browser-accessible Bitcoin wallet terminal application for use in conjunction with Ashigaru Whirlpool." \
      org.opencontainers.image.url="https://ashigaru.rs" \
      org.opencontainers.image.source="https://github.com/dennysubke/ashigaru-terminal" \
      org.opencontainers.image.version="${ASHI_VERSION}" \
      org.opencontainers.image.licenses="MIT" \
      io.portainer.icon="${ICON_URL}"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates tmux ttyd tini gosu procps tor torsocks \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 -s /bin/bash ashigaru

COPY artifacts/ashigaru_terminal_v${ASHI_VERSION}_amd64.deb /tmp/ashigaru_amd64.deb
COPY artifacts/ashigaru-terminal_${ASHI_VERSION}-1_arm64.deb /tmp/ashigaru_arm64.deb
COPY artifacts/ashigaru_terminal_v${ASHI_VERSION}_signed_hashes.txt /tmp/signed_hashes.txt

RUN set -eux; \
  if [ "${TARGETARCH:-}" = "amd64" ]; then \
    sed -i 's/\r$//' /tmp/signed_hashes.txt; \
    NAME="ashigaru_terminal_v${ASHI_VERSION}_amd64.deb"; \
    exp="$(awk -v n="$NAME" '$0 ~ "File name: " n {getline; print $NF; exit}' /tmp/signed_hashes.txt)"; \
    if [ -z "${exp:-}" ] || [ "${#exp}" -ne 64 ]; then exit 1; fi; \
    act="$(sha256sum /tmp/ashigaru_amd64.deb | awk '{print $1}')"; \
    test "$exp" = "$act" || exit 1; \
    dpkg -i /tmp/ashigaru_amd64.deb || (apt-get update && apt-get -f install -y && rm -rf /var/lib/apt/lists/*); \
  elif [ "${TARGETARCH:-}" = "arm64" ]; then \
    dpkg-deb -x /tmp/ashigaru_arm64.deb /; \
  else \
    exit 1; \
  fi; \
  rm -f /tmp/ashigaru_amd64.deb /tmp/ashigaru_arm64.deb /tmp/signed_hashes.txt; \
  if [ -d /opt/ashigaru-terminal ] && [ ! -d /opt/Ashigaru-terminal ]; then ln -s /opt/ashigaru-terminal /opt/Ashigaru-terminal; fi

ENV TERM=xterm-256color \
    TMUX_SESSION=ashigaru \
    PORT=7682 \
    ASHIGARU_CMD=/opt/Ashigaru-terminal/bin/Ashigaru-terminal \
    TOR_SOCKS_LISTEN=127.0.0.1 \
    TOR_SOCKS_PORT=9050 \
    TOR_CONTROL_ENABLE=0 \
    TOR_CONTROL_LISTEN=127.0.0.1 \
    TOR_CONTROL_PORT=9051 \
    TOR_DATADIR=/home/ashigaru/.tor

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh && chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 7682
EXPOSE 9050
EXPOSE 9051

WORKDIR /home/ashigaru
USER root

ENTRYPOINT ["/usr/bin/tini","--","/usr/local/bin/docker-entrypoint.sh"]
