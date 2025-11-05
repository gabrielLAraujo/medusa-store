#!/bin/bash

echo "🔐 Gerando senhas seguras para Medusa.js"
echo "========================================="
echo ""

echo "JWT_SECRET (copie e cole no Coolify):"
openssl rand -base64 32
echo ""

echo "COOKIE_SECRET (copie e cole no Coolify):"
openssl rand -base64 32
echo ""

echo "POSTGRES_PASSWORD (copie e cole no Coolify):"
openssl rand -base64 24
echo ""

echo "========================================="
echo "✅ Senhas geradas com sucesso!"
echo ""
echo "📋 Configure estas variáveis no painel do Coolify"
