#!/usr/bin/env bash
set -e

ulimit -n 65536 || true

PORT="${PORT:-7682}"
TMUX_SESSION="${TMUX_SESSION:-ashigaru}"
ASHIGARU_CMD="${ASHIGARU_CMD:-/opt/ashigaru-terminal/bin/Ashigaru-terminal}"
TOR_DATADIR="${TOR_DATADIR:-/home/ashigaru/.tor}"

mkdir -p "${TOR_DATADIR}"
chown -R ashigaru:ashigaru "${TOR_DATADIR}" || true

tor -f /etc/tor/torrc &

if ! tmux has-session -t "${TMUX_SESSION}" 2>/dev/null; then
  tmux new-session -d -s "${TMUX_SESSION}" "${ASHIGARU_CMD}"
fi

exec ttyd -p "${PORT}" -t "Ashigaru Terminal" tmux attach-session -t "${TMUX_SESSION}"
