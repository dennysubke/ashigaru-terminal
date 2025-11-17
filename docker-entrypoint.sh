#!/usr/bin/env bash
set -euo pipefail

mkdir -p "${TOR_DATADIR}"
chmod 700 "${TOR_DATADIR}"

if [[ "${TOR_CONTROL_ENABLE}" == "1" ]]; then
  tor --SocksPort "${TOR_SOCKS_LISTEN}:${TOR_SOCKS_PORT}" \
     --ControlPort "${TOR_CONTROL_LISTEN}:${TOR_CONTROL_PORT}" \
     --DataDirectory "${TOR_DATADIR}" \
     --RunAsDaemon 1
else
  tor --SocksPort "${TOR_SOCKS_LISTEN}:${TOR_SOCKS_PORT}" \
     --DataDirectory "${TOR_DATADIR}" \
     --RunAsDaemon 1
fi

sleep 2

if ! tmux has-session -t "${TMUX_SESSION}" 2>/dev/null; then
  tmux new-session -d -s "${TMUX_SESSION}" "${ASHIGARU_CMD}"
fi

exec ttyd -p "${PORT}" tmux attach-session -t "${TMUX_SESSION}"
