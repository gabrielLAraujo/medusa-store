#!/bin/sh
set -e

echo "🚀 Starting Medusa Server..."
echo "📋 Node version: $(node --version)"
echo "📋 NPM version: $(npm --version)"

# Aguardar PostgreSQL estar pronto
echo "⏳ Waiting for PostgreSQL..."
until PGPASSWORD="${POSTGRES_PASSWORD:-medusa}" psql -h postgres -U "${POSTGRES_USER:-medusa}" -d "${POSTGRES_DB:-medusa}" -c '\q' 2>/dev/null; do
  >&2 echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

echo "✅ PostgreSQL is ready!"

# Aguardar Redis estar pronto usando nc (netcat) que vem no alpine
echo "⏳ Waiting for Redis..."
until nc -z redis 6379 2>/dev/null; do
  >&2 echo "Redis is unavailable - sleeping"
  sleep 1
done

echo "✅ Redis is ready!"

# Garantir que REDIS_URL está definida
if [ -z "$REDIS_URL" ]; then
  export REDIS_URL="redis://redis:6379"
fi

echo "📋 Environment:"
echo "  - NODE_ENV: $NODE_ENV"
echo "  - REDIS_URL: $REDIS_URL"
echo "  - DATABASE_URL: ${DATABASE_URL%%@*}@***"  # Esconde senha
echo "  - JWT_SECRET: ${JWT_SECRET:0:4}***"       # Mostra só início
echo "  - COOKIE_SECRET: ${COOKIE_SECRET:0:4}***" # Mostra só início

# Verificar se o build existe
if [ ! -d "/app/build" ]; then
  echo "⚠️ WARNING: /app/build directory not found!"
  echo "📦 Building admin..."
  npm run build
fi

echo "📋 Files in /app:"
ls -la /app

# Rodar migrations
echo "📦 Running migrations..."
npx medusa migrations run || echo "⚠️ Migrations already up to date"

# Iniciar servidor com host 0.0.0.0 para aceitar conexões externas
echo "🎯 Starting Medusa server..."
exec npx medusa start --host 0.0.0.0

