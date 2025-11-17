#!/usr/bin/env bash
set -e

# 1. binfmt für ARM aktivieren (falls schon vorhanden, ist es egal)
docker run --privileged --rm tonistiigi/binfmt --install arm64 || true

# 2. buildx Builder anlegen oder verwenden
docker buildx create --name ashigaru-builder --use || docker buildx use ashigaru-builder

# 3. ARM Build ausführen
docker buildx build \
  --platform linux/arm64 \
  -f Dockerfile.armbuild \
  --output type=local,dest=./ashigaru-arm64-out \
  .

echo
echo "Fertige Dateien liegen jetzt unter ./ashigaru-arm64-out"
