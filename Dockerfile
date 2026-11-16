# Docling Serve (CPU build) for Railway.
# Official image from the Docling project, pinned by version and digest.
FROM quay.io/docling-project/docling-serve-cpu:v1.38.2@sha256:7a480a1604fa3b42efeddc7db9527690d9f9bc903226136013e2bfe6b1a4dfb0

# Defaults for Railway. Any of them can be overridden with a service variable.
ENV DOCLING_SERVE_ENABLE_UI=true \
    DOCLING_SERVE_MAX_SYNC_WAIT=600

COPY --chown=1001:0 --chmod=755 start.sh /opt/app-root/bin/railway-start.sh

EXPOSE 5001
CMD ["/opt/app-root/bin/railway-start.sh"]
