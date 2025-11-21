#!/usr/bin/env bash
set -e

ulimit -n 65536 || true

DISPLAY="${DISPLAY:-:0}"
ASHIGARU_CMD="${ASHIGARU_CMD:-/opt/Ashigaru-terminal/bin/Ashigaru-terminal}"
TOR_DATADIR="${TOR_DATADIR:-/home/ashigaru/.tor}"
NOVNC_PORT="${NOVNC_PORT:-7682}"
VNC_PORT="${VNC_PORT:-5900}"

mkdir -p "${TOR_DATADIR}"
chown -R ashigaru:ashigaru "${TOR_DATADIR}" || true

Xvfb "${DISPLAY}" -screen 0 1280x800x24 &
sleep 2

openbox &

tor -f /etc/tor/torrc &

su - ashigaru -c "${ASHIGARU_CMD}" &

x11vnc -display "${DISPLAY}" -rfbport "${VNC_PORT}" -forever -shared -nopw -quiet &

exec websockify --web=/usr/share/novnc "${NOVNC_PORT}" localhost:"${VNC_PORT}"
