#!/usr/bin/env bash
set -euo pipefail

mkdir -p "${TOR_DATADIR}"
chown -R ashigaru:ashigaru "${TOR_DATADIR}"
chmod 700 "${TOR_DATADIR}"

if [[ ! -x "${ASHIGARU_CMD}" ]]; then
  if [[ -x "/opt/Ashigaru-terminal/bin/Ashigaru-terminal" ]]; then
    ASHIGARU_CMD="/opt/Ashigaru-terminal/bin/Ashigaru-terminal"
  elif [[ -x "/opt/ashigaru-terminal/bin/Ashigaru-terminal" ]]; then
    ASHIGARU_CMD="/opt/ashigaru-terminal/bin/Ashigaru-terminal"
  else
    ls -R /opt || true
    exit 1
  fi
fi

if [[ "${TOR_CONTROL_ENABLE}" == "1" ]]; then
  gosu ashigaru tor --SocksPort "${TOR_SOCKS_LISTEN}:${TOR_SOCKS_PORT}" \
     --ControlPort "${TOR_CONTROL_LISTEN}:${TOR_CONTROL_PORT}" \
     --DataDirectory "${TOR_DATADIR}" \
     --RunAsDaemon 1
else
  gosu ashigaru tor --SocksPort "${TOR_SOCKS_LISTEN}:${TOR_SOCKS_PORT}" \
     --DataDirectory "${TOR_DATADIR}" \
     --RunAsDaemon 1
fi

sleep 2

if ! gosu ashigaru tmux has-session -t "${TMUX_SESSION}" 2>/dev/null; then
  gosu ashigaru tmux new-session -d -s "${TMUX_SESSION}" "${ASHIGARU_CMD}"
fi

exec gosu ashigaru ttyd -p "${PORT}" tmux attach-session -t "${TMUX_SESSION}"
