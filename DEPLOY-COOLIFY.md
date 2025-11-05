# 🚀 Deploy Medusa.js no Coolify

## Domínio Configurado
- **URL**: https://salmon-goldfish-177562.hostingersite.com

## 📋 Pré-requisitos
- Coolify instalado e rodando
- Docker no servidor
- Git (opcional, mas recomendado)

## 🔧 Configuração no Coolify

### Passo 1: Criar novo projeto no Coolify

1. Acesse seu painel do Coolify
2. Clique em **"+ New Resource"**
3. Escolha **"Docker Compose"** ou **"Public Repository"**

### Passo 2: Configurar o repositório

**Opção A - Com Git:**
```bash
# Se você ainda não tem um repositório Git:
cd /Users/gabrielaraujo/medusa-store
git init
git add .
git commit -m "Initial commit - Medusa.js Store"

# Criar repositório no GitHub e fazer push
git remote add origin [SEU_REPOSITORIO_GIT]
git push -u origin main
```

**Opção B - Upload direto:**
- Use o arquivo ZIP gerado: `medusa-store_20251105_100902.zip`

### Passo 3: Variáveis de Ambiente

Configure estas variáveis no Coolify:

```env
# Database
POSTGRES_USER=medusa
POSTGRES_PASSWORD=[GERE_SENHA_SEGURA]
POSTGRES_DB=medusa_db
DATABASE_URL=postgresql://medusa:[SENHA]@postgres:5432/medusa_db

# Redis
REDIS_URL=redis://redis:6379

# Secrets (IMPORTANTE: Gerar senhas seguras!)
JWT_SECRET=[GERE_STRING_ALEATORIA_SEGURA]
COOKIE_SECRET=[GERE_OUTRA_STRING_ALEATORIA]

# CORS
STORE_CORS=https://salmon-goldfish-177562.hostingersite.com
ADMIN_CORS=https://salmon-goldfish-177562.hostingersite.com

# Node
NODE_ENV=production
PORT=9000
```

### Passo 4: Gerar Senhas Seguras

Execute no seu terminal:
```bash
# JWT Secret
openssl rand -base64 32

# Cookie Secret
openssl rand -base64 32

# Postgres Password
openssl rand -base64 24
```

### Passo 5: Configurar Domínio

1. No Coolify, vá em **Domains**
2. Adicione: `salmon-goldfish-177562.hostingersite.com`
3. Configure SSL automático (Let's Encrypt)

### Passo 6: Deploy

1. Selecione o arquivo `docker-compose.yml` (ou `.coolify/docker-compose.yml`)
2. Clique em **Deploy**
3. Aguarde o build e deployment

## 🎯 Acessar a loja

Após o deploy bem-sucedido:

- **Admin Dashboard**: https://salmon-goldfish-177562.hostingersite.com/app
- **API**: https://salmon-goldfish-177562.hostingersite.com/store
- **Health Check**: https://salmon-goldfish-177562.hostingersite.com/health

### Credenciais Admin padrão
- Email: `admin@medusa-test.com`
- Senha: `supersecret`

**⚠️ IMPORTANTE**: Altere essas credenciais imediatamente após o primeiro login!

## 🔍 Monitoramento

Comandos úteis no servidor Coolify:

```bash
# Ver logs
docker logs -f medusa-backend

# Ver status dos containers
docker ps

# Acessar banco de dados
docker exec -it medusa-postgres psql -U medusa -d medusa_db

# Verificar Redis
docker exec -it medusa-redis redis-cli ping
```

## 🛠️ Troubleshooting

### Problema: Migrations não rodaram
```bash
docker exec -it medusa-backend npm run migration:run
```

### Problema: Admin não carrega
```bash
docker exec -it medusa-backend npm run build
```

### Problema: CORS errors
Verifique se as variáveis STORE_CORS e ADMIN_CORS estão corretas no Coolify.

## 📦 Estrutura de Portas

- **9000**: Backend API e Admin
- **7001**: Admin Dev (apenas desenvolvimento)
- **5432**: PostgreSQL (interno)
- **6379**: Redis (interno)

## 🔄 Atualizar a aplicação

1. Faça push das mudanças para o Git
2. No Coolify, clique em **Redeploy**
3. Ou configure Webhook para deploy automático

## 📚 Próximos passos

1. [ ] Configurar produtos iniciais
2. [ ] Configurar métodos de pagamento (Stripe)
3. [ ] Personalizar tema do admin
4. [ ] Adicionar categorias de produtos
5. [ ] Configurar envio de emails
6. [ ] Conectar frontend da loja

## 🆘 Suporte

- Documentação Medusa: https://docs.medusajs.com
- Documentação Coolify: https://coolify.io/docs

