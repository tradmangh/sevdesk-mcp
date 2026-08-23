#!/bin/sh
exec supergateway \
  --stdio "sevdesk-mcp" \
  --outputTransport streamableHttp \
  --port 8000 \
  --host 0.0.0.0 \
  --cors \
  --healthEndpoint /health \
  --oauth2Bearer "$MCP_AUTH_TOKEN"
