# 🚀 Guia de Deploy no Coolify

## 📋 Checklist Pré-Deploy

Antes de fazer deploy no Coolify, verifique:

- [ ] Conta Coolify configurada
- [ ] Servidor configurado no Coolify
- [ ] Repositório Git conectado
- [ ] Domínio configurado (opcional)

## 🔧 Configuração no Coolify

### 1. Criar Novo Recurso

1. Acesse seu Coolify
2. Clique em **"New Resource"**
3. Selecione **"Public Repository"** ou conecte seu Git
4. Cole a URL do repositório

### 2. Configurar Build

No Coolify, configure:

**Build Pack:** `nixpacks` ou `dockerfile`

**Dockerfile Location:** `./Dockerfile` (padrão)

**Docker Compose Location:** Deixe vazio (use só para dev local)

### 3. Configurar Variáveis de Ambiente

Adicione as seguintes variáveis em **Environment Variables**:

#### ✅ Obrigatórias

```env
NODE_ENV=production
```

**NÃO configure** `DATABASE_URL` e `REDIS_URL` manualmente! O Coolify irá injetá-las automaticamente quando você conectar os serviços.

#### 🔐 Secrets (GERE VALORES ÚNICOS!)

```env
JWT_SECRET=<GERE-UM-SECRET-FORTE-AQUI>
COOKIE_SECRET=<GERE-UM-SECRET-FORTE-AQUI>
```

**Como gerar secrets seguros:**

```bash
# No seu terminal
openssl rand -base64 32
```

#### 🌐 CORS (Opcional)

```env
STORE_CORS=https://seu-dominio.com
ADMIN_CORS=https://seu-dominio.com
```

**Nota:** Se não configurar, será usado `*` (todas as origens).

### 4. Adicionar Serviços

#### 🐘 PostgreSQL

1. No Coolify, vá em **"Storages & Databases"**
2. Clique em **"Add Database"**
3. Selecione **"PostgreSQL"**
4. Configure:
   - **Name:** `medusa-postgres`
   - **Version:** `15-alpine`
   - **Database:** `medusa`
   - **User:** `medusa`
   - **Password:** (gere uma senha forte)

5. Conecte ao seu aplicativo Medusa

**O Coolify irá automaticamente criar a variável:**
```env
DATABASE_URL=postgresql://medusa:senha@postgres:5432/medusa
```

#### 🔴 Redis

1. No Coolify, vá em **"Storages & Databases"**
2. Clique em **"Add Database"**
3. Selecione **"Redis"**
4. Configure:
   - **Name:** `medusa-redis`
   - **Version:** `7-alpine`

5. Conecte ao seu aplicativo Medusa

**O Coolify irá automaticamente criar a variável:**
```env
REDIS_URL=redis://redis:6379
```

### 5. Configurar Portas

**Portas Expostas:**
- `9000` - API e Admin (principal)
- `7001` - Admin (se separado)

**No Coolify:**
1. Vá em **Settings > Ports**
2. Adicione porta `9000` como pública
3. Configure domínio (opcional)

### 6. Deploy

1. Clique em **"Deploy"**
2. Aguarde o build (~3-5 minutos)
3. Monitore os logs

## 📊 Monitorando o Deploy

### Logs de Sucesso

Você deve ver nos logs:

```
🚀 Starting Medusa Server...
✅ PostgreSQL is ready!
✅ Redis is ready!
📦 Running migrations...
🎯 Starting Medusa server...
Server is ready on port: 9000
```

### Logs de Erro Comuns

#### ❌ "Local Event Bus installed"

**Causa:** Redis não está conectado

**Solução:**
1. Verifique se o Redis está rodando
2. Confirme que `REDIS_URL=redis://redis:6379`
3. Verifique os nomes dos serviços (deve ser `redis`)

#### ❌ "Error starting server" em plugins.js

**Causa:** Problema ao carregar plugins

**Solução:**
1. Verifique se todas as variáveis de ambiente estão configuradas
2. Confirme que o build foi feito corretamente
3. Verifique os logs do Redis

#### ❌ "Database connection failed"

**Causa:** PostgreSQL não conectado

**Solução:**
1. Verifique se o PostgreSQL está rodando
2. Confirme que `DATABASE_URL` está correta
3. Verifique nome do serviço (deve ser `postgres`)

## 🎯 Pós-Deploy

### 1. Verificar Health

Acesse: `https://seu-dominio.com/health`

Deve retornar:
```json
{
  "status": "ok"
}
```

### 2. Acessar Admin

Acesse: `https://seu-dominio.com/app`

### 3. Criar Usuário Admin

Via terminal do Coolify:

```bash
npx medusa user -e admin@email.com -p senha123
```

Ou acesse o terminal do container:

1. No Coolify, vá em **"Terminal"**
2. Execute:
   ```bash
   npx medusa user -e admin@email.com -p senha123
   ```

### 4. Seed do Banco (Opcional)

Para adicionar produtos de exemplo:

```bash
npx medusa seed -f ./data/seed.json
```

Credenciais padrão após seed:
- **Email:** `admin@medusa-test.com`
- **Senha:** `supersecret`

## 🔒 Segurança em Produção

### ⚠️ IMPORTANTE

Antes de usar em produção, MUDE:

1. **JWT_SECRET** - Gere um novo
2. **COOKIE_SECRET** - Gere um novo
3. **Senha do PostgreSQL** - Use senha forte
4. **CORS** - Configure apenas seus domínios:
   ```env
   STORE_CORS=https://loja.com,https://www.loja.com
   ADMIN_CORS=https://admin.loja.com
   ```

### 🛡️ Checklist de Segurança

- [ ] Secrets únicos e fortes
- [ ] CORS configurado (sem `*`)
- [ ] HTTPS habilitado
- [ ] Senha forte do PostgreSQL
- [ ] Backups configurados
- [ ] Monitoramento ativo

## 🐛 Troubleshooting

### Logs não aparecem no Coolify

1. Vá em **Logs**
2. Ative **"Stream Logs"**
3. Aumente "Number of Lines" para 500+

### Container reiniciando constantemente

1. Verifique health check nas configurações
2. Confirme que serviços (Postgres, Redis) estão rodando
3. Verifique variáveis de ambiente

### Admin não carrega

1. Confirme que o build foi feito (deve existir `/app/build`)
2. Verifique se porta 9000 está exposta
3. Limpe cache do navegador

### API retorna 502

1. Verifique se servidor iniciou (veja logs)
2. Confirme porta 9000 exposta
3. Verifique se domínio aponta corretamente

## 📞 Suporte

- **Coolify Docs:** https://coolify.io/docs
- **Medusa Discord:** https://discord.gg/medusajs
- **Issues:** Crie uma issue no GitHub

## 📝 Resumo das Variáveis

```env
# Ambiente
NODE_ENV=production

# Secrets (GERE NOVOS!)
JWT_SECRET=<seu-secret>
COOKIE_SECRET=<seu-secret>

# CORS (Opcional)
STORE_CORS=https://seu-dominio.com
ADMIN_CORS=https://seu-dominio.com

# Injetadas automaticamente pelo Coolify:
# DATABASE_URL=postgresql://...
# REDIS_URL=redis://...
```

---

**Boa sorte com o deploy! 🚀**

