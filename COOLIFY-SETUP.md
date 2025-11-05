# 🚀 Deploy no Coolify - Passo a Passo

## Seu Domínio
**desenvolvereviver.com** (ativo até 04/09/2026)

---

## 📋 Checklist de Deploy

### 1️⃣ Preparação Local

- [x] ✅ Dockerfile criado
- [x] ✅ docker-compose.yml configurado
- [x] ✅ .dockerignore criado
- [ ] ⚠️ Secrets de segurança gerados (rode: `./scripts/generate-secrets.sh`)

### 2️⃣ No Coolify

#### Passo 1: Criar Novo Projeto
1. Acesse seu Coolify na Hostinger
2. Clique em **"+ New"** → **"Project"**
3. Nome: `medusa-store` ou `loja-medusa`

#### Passo 2: Adicionar Serviços

**Opção A - Docker Compose (Recomendado)**
1. Clique em **"+ New Resource"** → **"Docker Compose"**
2. Conecte seu repositório Git ou faça upload manual
3. Coolify detectará o `docker-compose.yml` automaticamente

**Opção B - Aplicação Standalone**
1. Clique em **"+ New Resource"** → **"Application"**
2. Escolha **"Docker"** como tipo
3. Conecte repositório ou faça upload

#### Passo 3: Configurar Banco de Dados PostgreSQL
1. No mesmo projeto, adicione **"+ New Resource"** → **"PostgreSQL"**
2. Configurações:
   - **Nome**: `medusa-postgres`
   - **Database**: `medusa_db`
   - **User**: `medusa`
   - **Password**: (gere uma senha forte)
3. Anote a **DATABASE_URL** gerada

#### Passo 4: Configurar Redis
1. Adicione **"+ New Resource"** → **"Redis"**
2. Configurações:
   - **Nome**: `medusa-redis`
3. Anote a **REDIS_URL** gerada

#### Passo 5: Configurar Variáveis de Ambiente

No serviço Medusa, adicione estas variáveis:

```env
# Database (copie do PostgreSQL criado)
DATABASE_URL=postgresql://medusa:SENHA@postgres:5432/medusa_db

# Redis (copie do Redis criado)
REDIS_URL=redis://redis:6379

# Security (gere com: ./scripts/generate-secrets.sh)
JWT_SECRET=seu-secret-aqui
COOKIE_SECRET=seu-secret-aqui

# CORS
STORE_CORS=https://desenvolvereviver.com
ADMIN_CORS=https://desenvolvereviver.com

# Environment
NODE_ENV=production

# Database SSL
DATABASE_SSL=false
```

#### Passo 6: Configurar Domínio
1. Na aba **"Domains"** do serviço Medusa
2. Adicione: `desenvolvereviver.com`
3. Coolify configurará SSL automaticamente (Let's Encrypt)

#### Passo 7: Configurar Portas
- **Backend/API**: Porta `9000`
- **Admin Dashboard**: Porta `7001` (opcional, pode usar subdomínio)

Para Admin em subdomínio:
- Adicione `admin.desenvolvereviver.com` → Porta `7001`

### 3️⃣ Primeiro Deploy

1. Clique em **"Deploy"**
2. Aguarde o build (pode levar 5-10 minutos)
3. Verifique os logs para erros

### 4️⃣ Após o Deploy

#### Rodar Migrations
```bash
# No terminal do container Medusa
npm run migration:run
```

No Coolify:
1. Vá até o serviço Medusa
2. Clique em **"Terminal"** ou **"Execute Command"**
3. Execute: `npm run migration:run`

#### Criar Usuário Admin
```bash
npx medusa user -e admin@desenvolvereviver.com -p SuaSenhaForte123
```

#### (Opcional) Seed de Dados
```bash
npm run seed
```

---

## 🔧 Configurações Avançadas

### SSL/HTTPS
- Coolify configura automaticamente com Let's Encrypt
- Certifique-se que o DNS do domínio aponta para seu servidor

### Healthcheck
Adicione no `docker-compose.yml` (já configurado):
```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:9000/health"]
  interval: 30s
  timeout: 10s
  retries: 3
```

### Backup Automático
1. No PostgreSQL do Coolify, ative **"Automatic Backups"**
2. Configure frequência (recomendado: diária)

---

## 🎯 Acessos Pós-Deploy

Após deploy bem-sucedido:

- **🛍️ Loja (Frontend)**: https://desenvolvereviver.com
- **⚙️ Admin Dashboard**: https://desenvolvereviver.com/app
- **🔌 API Backend**: https://desenvolvereviver.com/store
- **📊 Health Check**: https://desenvolvereviver.com/health

Se configurou subdomínio para admin:
- **⚙️ Admin**: https://admin.desenvolvereviver.com

---

## ⚠️ Troubleshooting

### Deploy falha com erro de build
- Verifique logs no Coolify
- Certifique-se que `package.json` está correto
- Build pode precisar de mais memória

### Banco de dados não conecta
- Verifique `DATABASE_URL`
- Certifique-se que PostgreSQL está rodando
- Teste conexão no terminal do container

### Admin não carrega
- Verifique `ADMIN_CORS`
- Limpe cache do navegador
- Rebuilde o admin: `npm run build`

### Erro 502 Bad Gateway
- Verifique se serviço está rodando
- Veja logs do container
- Pode ser timeout de build (aumente timeout no Coolify)

---

## 📞 Próximos Passos

1. ✅ Deploy inicial
2. 🔐 Configurar Stripe para pagamentos
3. 📧 Configurar emails (SendGrid, Mailgun, etc)
4. 📦 Migrar uploads para S3/Cloudinary
5. 📈 Adicionar analytics
6. 🎨 Personalizar tema da loja

---

**✨ Dica Pro**: Mantenha os secrets em segurança e faça backup regular do banco de dados!

