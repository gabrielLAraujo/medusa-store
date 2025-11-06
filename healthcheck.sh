#!/bin/sh
# Health check script para o Coolify

# Verifica se o servidor está respondendo
curl -f http://localhost:9000/health || exit 1

echo "✅ Health check passed!"
exit 0

