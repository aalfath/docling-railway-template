# Docling on Railway

A Railway template for [Docling Serve](https://github.com/docling-project/docling-serve), the API and web UI for [Docling](https://github.com/docling-project/docling). It converts PDF, DOCX, PPTX, XLSX, HTML, images and scans into Markdown, JSON, HTML, text or DocTags, with layout analysis, table structure and OCR, for RAG pipelines and LLM tools.

## What it deploys

- **Docling Serve v1.38.2 (CPU build)**, built from this repo's `Dockerfile`, which pins the official image `quay.io/docling-project/docling-serve-cpu:v1.38.2` by digest. The layout, table, picture-classifier, RapidOCR and EasyOCR models are already in the image, so nothing is downloaded at boot.
- One public service with a Railway domain. No database and no volume: Docling Serve is stateless. Conversion results are kept in memory for a few minutes and can be fetched once.
- Web UI at `/ui` (the root URL redirects there) and API docs at `/docs`.
- Health check: `GET /ready` (open, no auth), which answers 200 once the models are loaded.

## Variables

| Variable | Default | Notes |
|---|---|---|
| `DOCLING_SERVE_API_KEY` | `${{secret(32)}}` | Generated at deploy time. Every API call needs the header `X-Api-Key: <key>`. Read it in the service's Variables tab |
| `PORT` | `5001` | Port Docling Serve listens on |

The start script refuses to start when `DOCLING_SERVE_API_KEY` is empty. To run without auth on purpose (for example behind your own gateway on the private network only), set `DOCLING_SERVE_ALLOW_NO_API_KEY=true`.

Any other [Docling Serve setting](https://github.com/docling-project/docling-serve/blob/main/docs/configuration.md) can be added as a variable, for example `DOCLING_SERVE_MAX_NUM_PAGES=200`, `DOCLING_SERVE_MAX_FILE_SIZE=52428800`, `DOCLING_SERVE_ENABLE_API_DOCS=false` or `UVICORN_WORKERS=2`. This template sets `DOCLING_SERVE_ENABLE_UI=true` and `DOCLING_SERVE_MAX_SYNC_WAIT=600` (seconds a synchronous call waits) in the `Dockerfile`.

## Try it

In the web UI, open the server panel, paste the API key, then drop in a file.

From the command line:

```sh
curl -X POST https://YOUR-DOMAIN/v1/convert/file \
  -H "X-Api-Key: YOUR-API-KEY" \
  -F "files=@document.pdf" \
  -F "to_formats=md"
```

From another service in the same Railway project, use the private network: `http://${{Docling.RAILWAY_PRIVATE_DOMAIN}}:5001`.

## Resources

Conversion runs on CPU. Plan for about 2 to 4 GB of RAM at rest and more for large documents. The first deploy pulls a 4.4 GB image, so the build takes a few minutes.

## Updates

Updates ship as commits to this repo's `main` branch: a new Docling Serve version means a new digest in the `Dockerfile` and an entry in [CHANGELOG.md](CHANGELOG.md). Railway then shows an "update available" notice on projects deployed from the template, and you choose when to apply it. Read the changelog first: breaking changes are listed at the top of each entry.
