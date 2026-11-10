#!/bin/sh
# Client auth: supergateway rejects /mcp requests without a valid key (401).
# The key is read from the SUPERGATEWAY_API_KEY env var (set in Coolify,
# source of truth: OpenBao secret/services/sevdesk-mcp#mcp_api_key) so it
# never appears on the command line. /health stays unauthenticated for
# Uptime Kuma. Claude connector sends "Authorization: Bearer <key>".
if [ -z "$SUPERGATEWAY_API_KEY" ]; then
  echo "FATAL: SUPERGATEWAY_API_KEY is not set; refusing to start unauthenticated." >&2
  exit 1
fi
exec supergateway \
  --stdio "exec sevdesk-mcp" \
  --outputTransport streamableHttp \
  --stateful \
  --sessionTimeout 120000 \
  --port 8000 \
  --host 0.0.0.0 \
  --cors \
  --healthEndpoint /health
