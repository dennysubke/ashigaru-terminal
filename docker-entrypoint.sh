#!/usr/bin/env bash
set -e

ulimit -n 65536 || true

PORT="${PORT:-7682}"
TMUX_SESSION="${TMUX_SESSION:-ashigaru}"
ASHIGARU_CMD="${ASHIGARU_CMD:-/opt/Ashigaru-terminal/bin/Ashigaru-terminal}"
TOR_DATADIR="${TOR_DATADIR:-/home/ashigaru/.tor}"
TTYD_TITLE="${TTYD_TITLE:-Ashigaru Terminal}"

mkdir -p "${TOR_DATADIR}"
chown -R ashigaru:ashigaru "${TOR_DATADIR}" || true

tor -f /etc/tor/torrc &

ARCH="$(uname -m)"

if ! tmux has-session -t "${TMUX_SESSION}" 2>/dev/null; then
  if [ "$ARCH" = "aarch64" ]; then
    tmux new-session -d -s "${TMUX_SESSION}" "/bin/bash"
  else
    tmux new-session -d -s "${TMUX_SESSION}" "${ASHIGARU_CMD}"
  fi
fi

exec ttyd \
  -p "${PORT}" \
  -t titleFixed="${TTYD_TITLE}" \
  tmux attach-session -t "${TMUX_SESSION}"
