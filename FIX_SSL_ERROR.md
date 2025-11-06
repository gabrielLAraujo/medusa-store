# 🔧 FIX: Erro SSL no Coolify

## ❌ Problema

```
Error: The server does not support SSL connections
    at Socket.<anonymous> (/app/node_modules/pg/lib/connection.js:76:37)
```

## ✅ Solução Imediata

### 📋 Passo a Passo no Coolify

1. **Faça commit das alterações:**

```bash
git add .
git commit -m "fix: desabilita SSL do PostgreSQL por padrão"
git push origin main
```

2. **No Coolify:**
   - Vá no seu projeto **Medusa**
   - Clique em **"Configuration"** > **"Environment Variables"**
   
3. **Verifique suas variáveis:**

   ✅ **DEVE ter:**
   ```env
   NODE_ENV=production
   DATABASE_URL=postgresql://medusa:senha@postgres:5432/medusa
   REDIS_URL=redis://redis:6379
   JWT_SECRET=seu-secret
   COOKIE_SECRET=seu-secret
   POSTGRES_USER=medusa
   POSTGRES_PASSWORD=senha
   POSTGRES_DB=medusa
   ```

   ❌ **NÃO deve ter:**
   ```env
   DATABASE_SSL=true  ← REMOVA se tiver
   ```

4. **Redeploy:**
   - Clique em **"Redeploy"**
   - Aguarde o build (5-10 min)

5. **Monitore os logs:**

   Você deve ver:
   
   ```
   🚀 Starting Medusa Server...
   ✅ PostgreSQL is ready!
   ✅ Redis is ready!
   📦 Running migrations...
   No migrations are pending
   🎯 Starting Medusa server...
   Server is ready on port: 9000  ← Sucesso!
   ```

## 🎯 O que Foi Alterado

### Antes (causava erro):

```javascript
database_extra: 
  process.env.NODE_ENV !== "development"
    ? { ssl: { rejectUnauthorized: false } }  // ❌ Sempre usa SSL em prod
    : {},
```

### Depois (correto):

```javascript
database_extra: 
  process.env.DATABASE_SSL === "true"
    ? { ssl: { rejectUnauthorized: false } }  // ✅ Só usa SSL se explícito
    : {},
```

## 📊 Checklist Pós-Deploy

- [ ] Commit feito e pushed
- [ ] Variável `DATABASE_SSL` removida (se existir)
- [ ] Redeploy feito no Coolify
- [ ] Logs mostram "PostgreSQL is ready!"
- [ ] Logs mostram "Redis is ready!"
- [ ] Logs mostram "Server is ready on port: 9000"
- [ ] `/health` retorna `{"status":"ok"}`
- [ ] `/app` carrega o admin

## 🆘 Se Ainda Não Funcionar

1. **Verifique senha do PostgreSQL:**
   
   A senha em `POSTGRES_PASSWORD` deve ser a mesma em `DATABASE_URL`:
   
   ```env
   POSTGRES_PASSWORD=minhasenha
   DATABASE_URL=postgresql://medusa:minhasenha@postgres:5432/medusa
                                      ^^^^^^^^^ mesma senha
   ```

2. **Verifique logs de TODOS os serviços:**
   
   No Coolify, veja logs de:
   - `postgres` - Deve mostrar "ready to accept connections"
   - `redis` - Deve mostrar "Ready to accept connections"
   - `medusa` - Deve mostrar erro específico

3. **Force Rebuild:**
   
   No Coolify:
   - Clique em **"Stop"**
   - Clique em **"Force Rebuild"**

4. **Consulte troubleshooting completo:**
   
   [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

---

## ✅ Depois que Funcionar

### Criar usuário admin:

No terminal do Coolify (serviço `medusa`):

```bash
npx medusa user -e admin@email.com -p senha123
```

### Acessar:

- **Admin**: https://seu-dominio.com/app
- **API**: https://seu-dominio.com/health

### Seed (opcional):

```bash
npx medusa seed -f ./data/seed.json
```

Credenciais após seed:
- Email: `admin@medusa-test.com`
- Senha: `supersecret`

---

**Boa sorte! 🚀**

