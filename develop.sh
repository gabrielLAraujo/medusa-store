#!/bin/sh
set -e

echo "🔧 Development mode..."

# Rodar migrations
echo "📦 Running migrations..."
npx medusa migrations run

# Iniciar servidor em modo desenvolvimento
echo "🎯 Starting Medusa development server..."
exec npx medusa develop

