# 🚀 Deploy no Coolify usando Docker Compose

Este guia explica como fazer deploy da Medusa Store no Coolify usando o `docker-compose.yml`.

## 📋 Vantagens desta Abordagem

✅ **Tudo em um arquivo** - PostgreSQL, Redis e Medusa configurados juntos  
✅ **Health checks automáticos** - Garante que serviços estejam prontos  
✅ **Network isolado** - Segurança melhorada  
✅ **Volumes persistentes** - Dados não são perdidos em redeploys  

## 🔧 Configuração no Coolify

### 1. Criar Novo Recurso

1. Acesse seu **Coolify**
2. Vá em **Projects** > Seu Projeto
3. Clique em **"Add Resource"**
4. Selecione **"Docker Compose"**

### 2. Conectar Repositório

1. **Source Type**: GitHub/GitLab/Bitbucket
2. **Repository**: Cole a URL do seu repositório
3. **Branch**: `main` (ou sua branch principal)
4. **Docker Compose Location**: `docker-compose.yml` (raiz do projeto)

### 3. Configurar Variáveis de Ambiente

No Coolify, adicione estas variáveis em **Environment Variables**:

#### 🔐 Obrigatórias

```env
# Ambiente
NODE_ENV=production

# Secrets (GERE VALORES ÚNICOS E FORTES!)
JWT_SECRET=<gere-um-secret-aqui>
COOKIE_SECRET=<gere-um-secret-aqui>

# Banco de Dados
POSTGRES_USER=medusa
POSTGRES_PASSWORD=<senha-forte-aqui>
POSTGRES_DB=medusa

# URLs (serão geradas automaticamente)
DATABASE_URL=postgresql://medusa:<senha-forte-aqui>@postgres:5432/medusa
REDIS_URL=redis://redis:6379
```

#### 🌐 Opcionais (Recomendadas)

```env
# CORS - Substitua pelo seu domínio
STORE_CORS=https://seu-dominio.com,https://www.seu-dominio.com
ADMIN_CORS=https://seu-dominio.com
```

### 4. Como Gerar Secrets Fortes

```bash
# No seu terminal local, execute 3 vezes:
openssl rand -base64 32
```

Use os valores gerados para:
1. `JWT_SECRET`
2. `COOKIE_SECRET`
3. `POSTGRES_PASSWORD`

### 5. Configurar Portas

O Coolify detectará automaticamente a porta **9000** do serviço `medusa`.

**Expor Publicamente:**
1. No Coolify, vá em **Settings** > **Ports**
2. Certifique-se que a porta `9000` está exposta
3. Configure seu domínio (opcional)

### 6. Deploy

1. Clique em **"Deploy"**
2. Aguarde o build (pode demorar 5-10 minutos na primeira vez)
3. Monitore os logs

## 📊 Monitorando o Deploy

### ✅ Logs de Sucesso

Você verá nos logs de cada serviço:

**PostgreSQL (`postgres`):**
```
database system is ready to accept connections
```

**Redis (`redis`):**
```
Ready to accept connections
```

**Medusa (`medusa`):**
```
🚀 Starting Medusa Server...
✅ PostgreSQL is ready!
✅ Redis is ready!
📦 Running migrations...
🎯 Starting Medusa server...
Server is ready on port: 9000
```

### ❌ Erros Comuns

#### Erro: "PostgreSQL is unavailable - sleeping"

**Causa:** PostgreSQL não iniciou ainda ou credenciais incorretas

**Solução:**
1. Verifique os logs do serviço `postgres`
2. Confirme que `POSTGRES_USER`, `POSTGRES_PASSWORD` e `POSTGRES_DB` estão corretos
3. Verifique se `DATABASE_URL` usa as mesmas credenciais

#### Erro: "Redis is unavailable - sleeping"

**Causa:** Redis não iniciou ainda

**Solução:**
1. Verifique os logs do serviço `redis`
2. Aguarde mais tempo (pode demorar 30-60s)

#### Erro: "Local Event Bus installed"

**Causa:** Medusa não consegue conectar no Redis

**Solução:**
1. Confirme que `REDIS_URL=redis://redis:6379`
2. Verifique se o serviço `redis` está rodando
3. Veja os logs do Redis para erros

## 🎯 Pós-Deploy

### 1. Verificar Health

Acesse seu domínio ou IP:

```
https://seu-dominio.com/health
```

Deve retornar:
```json
{
  "status": "ok"
}
```

### 2. Acessar o Admin

```
https://seu-dominio.com/app
```

### 3. Criar Usuário Admin

#### Pelo Terminal do Coolify:

1. No Coolify, vá em **Terminal**
2. Selecione o serviço **`medusa`**
3. Execute:

```bash
npx medusa user -e admin@email.com -p senha123
```

#### Via Docker Exec (alternativa):

```bash
docker compose exec medusa npx medusa user -e admin@email.com -p senha123
```

### 4. Seed do Banco (Opcional)

Para adicionar produtos de exemplo:

```bash
npx medusa seed -f ./data/seed.json
```

**Credenciais padrão após seed:**
- Email: `admin@medusa-test.com`
- Senha: `supersecret`

## 📝 Estrutura de Serviços

O `docker-compose.yml` cria 3 serviços:

```
medusa-network (rede isolada)
├── postgres (PostgreSQL 15)
│   ├── Porta: Interna apenas
│   ├── Volume: postgres_data
│   └── Health Check: ✓
│
├── redis (Redis 7)
│   ├── Porta: Interna apenas
│   ├── Volume: redis_data
│   └── Health Check: ✓
│
└── medusa (Medusa Server)
    ├── Porta: 9000 (pública)
    ├── Volume: medusa_uploads
    ├── Health Check: ✓
    └── Depende de: postgres + redis
```

## 🔄 Atualizações

### Fazer Redeploy

No Coolify:
1. Clique em **"Redeploy"**
2. Aguarde rebuild

### Rebuild Completo

Se houver problemas:
1. Clique em **"Force Rebuild"**
2. Isso recria todos os containers do zero

### Aplicar Migrations Manualmente

```bash
npx medusa migrations run
```

## 🔒 Checklist de Segurança

Antes de usar em produção:

- [ ] `JWT_SECRET` único e forte (32+ caracteres)
- [ ] `COOKIE_SECRET` único e forte (32+ caracteres)
- [ ] `POSTGRES_PASSWORD` forte
- [ ] CORS configurado (sem `*`)
- [ ] HTTPS habilitado no Coolify
- [ ] Backups automáticos configurados
- [ ] Domínio personalizado configurado

## 🐛 Troubleshooting Avançado

### Ver logs de um serviço específico

No Coolify:
1. Vá em **Logs**
2. Filtre por serviço: `postgres`, `redis` ou `medusa`

### Restart de um serviço específico

```bash
docker compose restart postgres
docker compose restart redis
docker compose restart medusa
```

### Verificar status dos containers

```bash
docker compose ps
```

### Verificar network

```bash
docker compose exec medusa ping postgres
docker compose exec medusa ping redis
```

### Acessar banco de dados

```bash
docker compose exec postgres psql -U medusa -d medusa
```

### Limpar tudo e recomeçar

⚠️ **CUIDADO**: Isso apaga TODOS os dados!

```bash
docker compose down -v
docker compose up -d
```

## 📊 Recursos do Sistema

### Uso Recomendado

- **CPU**: 2+ cores
- **RAM**: 2GB+ (mínimo), 4GB+ (recomendado)
- **Disco**: 10GB+ (para dados + logs)

### Limitar Recursos (Opcional)

Edite `docker-compose.yml`:

```yaml
services:
  medusa:
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 2G
        reservations:
          cpus: '1'
          memory: 1G
```

## 📖 Próximos Passos

1. **Configurar Backups**: Configure backups automáticos no Coolify
2. **Monitoring**: Adicione Sentry ou similar
3. **CI/CD**: Configure deploy automático no push
4. **Storefront**: Instale o Next.js storefront
5. **CDN**: Configure CDN para uploads/imagens

## 🆘 Suporte

- **Coolify Docs**: https://coolify.io/docs
- **Medusa Discord**: https://discord.gg/medusajs
- **Issues**: Abra uma issue no GitHub

---

**Configuração completa! 🎉**

Seu Medusa Store está rodando com PostgreSQL, Redis e Medusa Server totalmente orquestrados pelo Docker Compose no Coolify.

