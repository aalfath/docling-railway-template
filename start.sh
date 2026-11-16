#!/bin/sh
# Start Docling Serve on Railway's PORT (default 5001).
# Refuses to start without an API key, so a public deploy is never left open.
set -e

if [ -z "${DOCLING_SERVE_API_KEY}" ] && [ "${DOCLING_SERVE_ALLOW_NO_API_KEY}" != "true" ]; then
  echo "DOCLING_SERVE_API_KEY is empty. Set it (the template generates one), or set DOCLING_SERVE_ALLOW_NO_API_KEY=true to run without auth." >&2
  exit 1
fi

export UVICORN_PORT="${PORT:-5001}"
exec docling-serve run
