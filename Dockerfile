FROM node:24-slim

# Pinned: supergateway >=4 is required for --apiKey / SUPERGATEWAY_API_KEY.
RUN npm install -g supergateway@4.2.2 @honeyfield/sevdesk-mcp@1.2.6

WORKDIR /app

EXPOSE 8000

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD node -e "fetch('http://localhost:8000/health').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"

CMD ["/app/entrypoint.sh"]
