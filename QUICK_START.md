# ⚡ Quick Start - Medusa Store

Guias rápidos para começar imediatamente!

## 🚀 Deploy no Coolify (Docker Compose)

### 1️⃣ Configure no Coolify

1. **Crie novo recurso**: Docker Compose
2. **Conecte repositório**: GitHub/GitLab
3. **Docker Compose Location**: `docker-compose.yml`

### 2️⃣ Adicione Variáveis de Ambiente

Copie do arquivo `env.coolify.example` e configure:

```env
NODE_ENV=production
JWT_SECRET=<gere com: openssl rand -base64 32>
COOKIE_SECRET=<gere com: openssl rand -base64 32>
POSTGRES_USER=medusa
POSTGRES_PASSWORD=<senha-forte>
POSTGRES_DB=medusa
DATABASE_URL=postgresql://medusa:<senha-forte>@postgres:5432/medusa
REDIS_URL=redis://redis:6379
STORE_CORS=https://seu-dominio.com
ADMIN_CORS=https://seu-dominio.com
```

### 3️⃣ Deploy

Clique em **"Deploy"** e aguarde (~5-10 min)

### 4️⃣ Crie Usuário Admin

No terminal do Coolify (serviço `medusa`):

```bash
npx medusa user -e admin@email.com -p senha123
```

### 5️⃣ Acesse

- **Admin**: `https://seu-dominio.com/app`
- **API**: `https://seu-dominio.com/health`

✅ **Pronto!**

---

## 💻 Desenvolvimento Local

### 1️⃣ Clone o repositório

```bash
git clone <seu-repo>
cd medusa-store
```

### 2️⃣ Inicie com Docker Compose

```bash
docker compose up -d
```

### 3️⃣ Crie usuário admin

```bash
docker compose exec medusa npx medusa user -e admin@email.com -p senha123
```

### 4️⃣ Acesse

- **Admin**: http://localhost:9000/app
- **API**: http://localhost:9000/health

✅ **Pronto para desenvolver!**

---

## 📚 Documentação Completa

- [Deploy Coolify Docker Compose](./COOLIFY_DOCKER_COMPOSE.md) - Guia detalhado
- [Deploy Coolify Tradicional](./COOLIFY_DEPLOY.md) - Deploy sem docker-compose
- [README Principal](./README.md) - Documentação completa

---

## 🆘 Problemas?

### Container reiniciando

```bash
# Ver logs
docker compose logs medusa

# Ou no Coolify: Logs > medusa
```

### "Local Event Bus installed"

Verifique: `REDIS_URL=redis://redis:6379`

### PostgreSQL não conecta

Verifique `DATABASE_URL` e `POSTGRES_PASSWORD` iguais

### Mais ajuda

- [Troubleshooting](./COOLIFY_DOCKER_COMPOSE.md#-troubleshooting-avançado)
- [Discord Medusa](https://discord.gg/medusajs)

