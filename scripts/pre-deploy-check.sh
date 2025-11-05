#!/bin/bash

echo "🔍 Verificando pré-requisitos de deploy..."
echo ""

ERRORS=0

# Verificar arquivos essenciais
echo "📋 Verificando arquivos essenciais..."
files=("package.json" "Dockerfile" "docker-compose.yml" "medusa-config.js")
for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    echo "  ✅ $file encontrado"
  else
    echo "  ❌ $file NÃO encontrado"
    ERRORS=$((ERRORS + 1))
  fi
done
echo ""

# Verificar node_modules
echo "📦 Verificando dependências..."
if [ -d "node_modules" ]; then
  echo "  ✅ node_modules instalado"
else
  echo "  ⚠️  node_modules não encontrado"
  echo "  💡 Execute: npm install"
fi
echo ""

# Verificar Docker
echo "🐳 Verificando Docker..."
if command -v docker &> /dev/null; then
  echo "  ✅ Docker instalado ($(docker --version))"
else
  echo "  ⚠️  Docker não encontrado"
  echo "  💡 Instale Docker: https://docs.docker.com/get-docker/"
fi
echo ""

# Verificar docker-compose
echo "🐳 Verificando Docker Compose..."
if command -v docker-compose &> /dev/null; then
  echo "  ✅ Docker Compose instalado ($(docker-compose --version))"
elif docker compose version &> /dev/null; then
  echo "  ✅ Docker Compose (plugin) instalado"
else
  echo "  ⚠️  Docker Compose não encontrado"
fi
echo ""

# Resumo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $ERRORS -eq 0 ]; then
  echo "✅ TUDO OK! Projeto pronto para deploy!"
  echo ""
  echo "📌 Próximos passos:"
  echo "  1. Gere os secrets: ./scripts/generate-secrets.sh"
  echo "  2. Configure as variáveis no Coolify"
  echo "  3. Faça upload do projeto ou conecte Git"
  echo "  4. Deploy! 🚀"
else
  echo "❌ Encontrados $ERRORS erro(s)"
  echo "   Corrija os problemas antes de fazer deploy"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Informações adicionais
echo "ℹ️  Domínio: desenvolvereviver.com"
echo "ℹ️  Platform: Coolify/Hostinger"
echo "ℹ️  Guia completo: COOLIFY-SETUP.md"
echo ""

