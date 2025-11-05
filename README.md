# 🛍️ Loja Medusa.js - desenvolvereviver.com

Loja virtual completa construída com Medusa.js, PostgreSQL e Redis.

## 🚀 Deploy Rápido

### Seus Secrets de Segurança (GUARDE COM SEGURANÇA!)

```env
JWT_SECRET=SKE4+mEMXM8CK/QBMS09mFDLSmAKa1uB4L/FPQkF7qM=
COOKIE_SECRET=22A1d54BfIzlyf/UR4vN/+B/dSs7E2NwwenDzM2uf8c=
```

### Quick Start

```bash
# 1. Verificar se está tudo pronto
./scripts/pre-deploy-check.sh

# 2. Gerar novos secrets (se necessário)
./scripts/generate-secrets.sh

# 3. Desenvolvimento local
npm install
npm run dev

# 4. Deploy no Coolify
# Siga o guia: COOLIFY-SETUP.md
```

## 📚 Documentação

- **[COOLIFY-SETUP.md](COOLIFY-SETUP.md)** - Guia completo de deploy no Coolify
- **[README-DEPLOY.md](README-DEPLOY.md)** - Informações gerais de deploy

## 🌐 Domínio

**desenvolvereviver.com** (ativo até 04/09/2026)

## 🏗️ Arquitetura

- **Backend**: Medusa.js v1.20.6 (Node.js 18+)
- **Banco de Dados**: PostgreSQL 15
- **Cache**: Redis 7
- **Admin**: Medusa Admin Dashboard
- **Deploy**: Docker + Coolify + Hostinger

## 📦 Serviços

| Serviço | Porta | Descrição |
|---------|-------|-----------|
| Backend API | 9000 | API principal do Medusa |
| Admin Dashboard | 7001 | Painel administrativo |
| PostgreSQL | 5432 | Banco de dados |
| Redis | 6379 | Cache e event bus |

## 🔧 Variáveis de Ambiente

```env
# Database
DATABASE_URL=postgresql://user:pass@host:5432/medusa_db

# Redis
REDIS_URL=redis://redis:6379

# Security
JWT_SECRET=seu-secret-aqui
COOKIE_SECRET=seu-secret-aqui

# CORS
STORE_CORS=https://desenvolvereviver.com
ADMIN_CORS=https://desenvolvereviver.com

# Environment
NODE_ENV=production
```

## 🎯 Comandos Úteis

```bash
# Desenvolvimento
npm run dev              # Modo desenvolvimento
npm run build           # Build produção
npm start               # Iniciar produção

# Banco de Dados
npm run migration:generate  # Gerar migration
npm run migration:run       # Rodar migrations
npm run seed               # Popular com dados

# Docker
docker-compose up -d       # Subir todos os serviços
docker-compose logs -f     # Ver logs
docker-compose down        # Parar serviços

# Scripts de Deploy
./scripts/pre-deploy-check.sh   # Verificar pré-requisitos
./scripts/generate-secrets.sh   # Gerar secrets
```

## 📱 Acessos

Após deploy:

- **Loja**: https://desenvolvereviver.com
- **Admin**: https://desenvolvereviver.com/app
- **API**: https://desenvolvereviver.com/store
- **Health**: https://desenvolvereviver.com/health

## 🔐 Primeiro Acesso

Após deploy, crie um usuário admin:

```bash
npx medusa user -e admin@desenvolvereviver.com -p SuaSenhaForte123
```

## 🎨 Próximos Passos

- [ ] Configurar Stripe para pagamentos
- [ ] Configurar email (SendGrid/Mailgun)
- [ ] Migrar uploads para S3
- [ ] Adicionar Google Analytics
- [ ] Personalizar tema
- [ ] Configurar SEO

## 📞 Suporte

- **Medusa Docs**: https://docs.medusajs.com
- **Medusa Discord**: https://discord.gg/medusajs
- **Coolify Docs**: https://coolify.io/docs

---

**Feito com ❤️ usando Medusa.js**

