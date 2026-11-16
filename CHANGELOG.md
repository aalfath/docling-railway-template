# Changelog

Each entry lists breaking changes first. Read it before you apply an update to a project deployed from the template.

## 1.38.2-1 (2026-11-16)

- README: Deploy on Railway button linking to the published template . No change to the deployed service.

## 1.38.2 (2026-11-16)

First release of the template.

- Docling Serve v1.38.2, CPU build: `quay.io/docling-project/docling-serve-cpu:v1.38.2@sha256:7a480a1604fa3b42efeddc7db9527690d9f9bc903226136013e2bfe6b1a4dfb0`.
- Web UI on at `/ui` (the root URL redirects there). API key required (`X-Api-Key`), generated at deploy time.
- Listens on `PORT` (5001) on `0.0.0.0`, which the public domain and the private network (IPv4) both reach.
- Health check: `GET /ready`, which answers 200 once the models are loaded.
