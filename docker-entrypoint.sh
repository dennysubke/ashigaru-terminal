#!/usr/bin/env bash
set -e

# Sinnvolles Limit für File Descriptors setzen (verhindert OOM allocating ... fds)
ulimit -n 65536 || true

# Defaults
PORT="${PORT:-7682}"
TMUX_SESSION="${TMUX_SESSION:-ashigaru}"
ASHIGARU_CMD="${ASHIGARU_CMD:-/opt/ashigaru-terminal/bin/Ashigaru-terminal}"
TOR_DATADIR="${TOR_DATADIR:-/home/ashigaru/.tor}"

# Tor-Verzeichnisse vorbereiten
mkdir -p "${TOR_DATADIR}"
chown -R ashigaru:ashigaru "${TOR_DATADIR}" || true

# Tor im Hintergrund starten
tor -f /etc/tor/torrc &

# tmux-Session anlegen, falls noch nicht vorhanden
if ! tmux has-session -t "${TMUX_SESSION}" 2>/dev/null; then
  tmux new-session -d -s "${TMUX_SESSION}" "${ASHIGARU_CMD}"
fi

# Terminal-Server starten: ttyd + tmux
exec ttyd -p "${PORT}" tmux attach-session -t "${TMUX_SESSION}"
