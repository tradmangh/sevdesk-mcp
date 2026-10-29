#!/bin/sh
exec supergateway \
  --stdio "exec sevdesk-mcp" \
  --outputTransport streamableHttp \
  --stateful \
  --sessionTimeout 120000 \
  --port 8000 \
  --host 0.0.0.0 \
  --cors \
  --healthEndpoint /health \
  --oauth2Bearer "$MCP_AUTH_TOKEN"
