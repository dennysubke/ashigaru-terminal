#!/usr/bin/env bash
set -e

ulimit -n 65536 || true

TERM="${TERM:-xterm-256color}"
TMUX_SESSION="${TMUX_SESSION:-ashigaru}"
PORT="${PORT:-7682}"
ASHIGARU_CMD="${ASHIGARU_CMD:-/opt/Ashigaru-terminal/bin/Ashigaru-terminal}"
TOR_DATADIR="${TOR_DATADIR:-/home/ashigaru/.tor}"
TTYD_TITLE="${TTYD_TITLE:-Ashigaru Terminal}"

mkdir -p "${TOR_DATADIR}"
chown -R ashigaru:ashigaru "${TOR_DATADIR}" || true

tor -f /etc/tor/torrc &

if tmux has-session -t "$TMUX_SESSION" 2>/dev/null; then
  :
else
  tmux new-session -d -s "$TMUX_SESSION" "$ASHIGARU_CMD"
fi

exec ttyd \
  --port "${PORT}" \
  --base-path / \
  --client-option titleFixed="${TTYD_TITLE}" \
  tmux attach-session -t "${TMUX_SESSION}"
