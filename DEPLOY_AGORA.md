# 🚀 DEPLOY AGORA - Solução do Erro SSL

## ❌ Erro que você estava tendo:

```
Error: The server does not support SSL connections
```

## ✅ CORRIGIDO!

O problema era que o Medusa tentava usar SSL no PostgreSQL, mas o PostgreSQL do Docker Compose não tem SSL.

---

## 📋 FAÇA AGORA (3 passos):

### 1️⃣ Commit das Correções

```bash
git add .
git commit -m "fix: corrige erro SSL do PostgreSQL no Coolify"
git push origin main
```

### 2️⃣ No Coolify

1. Vá em **Environment Variables**
2. **CERTIFIQUE-SE** que NÃO tem `DATABASE_SSL=true`
3. Se tiver, REMOVA

Suas variáveis devem ser:

```env
NODE_ENV=production
POSTGRES_USER=medusa
POSTGRES_PASSWORD=sua-senha-aqui
POSTGRES_DB=medusa
DATABASE_URL=postgresql://medusa:sua-senha-aqui@postgres:5432/medusa
REDIS_URL=redis://redis:6379
JWT_SECRET=seu-secret
COOKIE_SECRET=seu-secret
STORE_CORS=*
ADMIN_CORS=*
```

### 3️⃣ Redeploy

1. Clique em **"Redeploy"**
2. Aguarde 5-10 minutos
3. Veja os logs

---

## ✅ Logs de Sucesso

Você DEVE ver:

```
🚀 Starting Medusa Server...
📋 Node version: v18.20.8
📋 NPM version: 10.8.2
⏳ Waiting for PostgreSQL...
✅ PostgreSQL is ready!
⏳ Waiting for Redis...
✅ Redis is ready!
📦 Running migrations...
No migrations are pending
🎯 Starting Medusa server...
Server is ready on port: 9000  ← ISSO AQUI!
```

---

## 🎯 Depois que Funcionar

### Criar Admin:

No terminal do Coolify (serviço `medusa`):

```bash
npx medusa user -e admin@email.com -p senha123
```

### Acessar:

- **Admin**: `https://seu-dominio.com/app`
- **Health**: `https://seu-dominio.com/health`

---

## 🆘 Se Ainda Tiver Problema

Veja: [FIX_SSL_ERROR.md](./FIX_SSL_ERROR.md)

Ou: [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

---

**É ISSO! Vai funcionar agora! 🎉**
