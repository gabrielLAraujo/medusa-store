# 🛍️ Medusa Store - E-commerce Headless

Loja e-commerce completa construída com [Medusa.js](https://medusajs.com/) - Plataforma headless de código aberto.

## ⚡ Quick Start

**Deploy no Coolify em 5 minutos?** → [QUICK_START.md](./QUICK_START.md)

**Deploy com Docker Compose (Recomendado)?** → [COOLIFY_DOCKER_COMPOSE.md](./COOLIFY_DOCKER_COMPOSE.md)

## 🚀 Tecnologias

- **Backend**: Medusa.js v1.20+
- **Admin**: @medusajs/admin v7.1+
- **Banco de Dados**: PostgreSQL 15
- **Cache/Event Bus**: Redis 7
- **Container**: Docker + Docker Compose
- **Deploy**: Coolify

## 📋 Pré-requisitos

- Docker & Docker Compose
- Node.js 18+ (para desenvolvimento local sem Docker)
- Git

## 🏃 Quick Start - Desenvolvimento Local com Docker

### 1. Clone o repositório

```bash
git clone <seu-repositorio>
cd medusa-store
```

### 2. Inicie os containers

```bash
docker compose up --build
```

Isso irá:
- ✅ Criar e iniciar PostgreSQL na porta 5432
- ✅ Criar e iniciar Redis na porta 6379
- ✅ Build da aplicação Medusa
- ✅ Executar migrations automaticamente
- ✅ Iniciar o servidor na porta 9000

### 3. Acesse a aplicação

- **API**: http://localhost:9000/health
- **Admin Dashboard**: http://localhost:9000/app
- **Store API**: http://localhost:9000/store/products

### 4. Seed do banco de dados (opcional)

```bash
docker exec medusa-server npx medusa seed -f ./data/seed.json
```

### 5. Criar usuário admin

```bash
docker exec -it medusa-server npx medusa user -e admin@email.com -p senha123
```

## 🔧 Desenvolvimento Local sem Docker

### 1. Instale as dependências

```bash
npm install
```

### 2. Configure variáveis de ambiente

Crie um arquivo `.env`:

```env
DATABASE_URL=postgresql://medusa:medusa@localhost:5432/medusa
REDIS_URL=redis://localhost:6379
JWT_SECRET=supersecret_change_in_production
COOKIE_SECRET=supersecret_change_in_production
STORE_CORS=http://localhost:8000
ADMIN_CORS=http://localhost:7001,http://localhost:9000
```

### 3. Certifique-se que PostgreSQL e Redis estão rodando

### 4. Execute migrations

```bash
npm run migrations
```

### 5. Inicie o servidor

```bash
npm run dev
```

## 🌐 Deploy no Coolify

### 🎯 Método 1: Docker Compose (Recomendado)

**Vantagens:**
- ✅ Tudo configurado em um arquivo
- ✅ PostgreSQL + Redis + Medusa juntos
- ✅ Health checks automáticos
- ✅ Network isolado

**Guia Completo:** [COOLIFY_DOCKER_COMPOSE.md](./COOLIFY_DOCKER_COMPOSE.md)

**Resumo:**
1. No Coolify, crie recurso **"Docker Compose"**
2. Aponte para `docker-compose.yml` na raiz
3. Configure variáveis de ambiente do arquivo `env.coolify.example`
4. Deploy!

### 🎯 Método 2: Deploy Tradicional

**Guia Completo:** [COOLIFY_DEPLOY.md](./COOLIFY_DEPLOY.md)

**Resumo:**
1. No Coolify, crie recurso **"Public Repository"**
2. Adicione serviços PostgreSQL e Redis separadamente
3. Configure variáveis de ambiente
4. Deploy!

## 📝 Scripts Disponíveis

```bash
npm run dev          # Desenvolvimento com hot-reload
npm run build        # Build do admin dashboard
npm start            # Produção
npm run seed         # Seed do banco com dados de exemplo
npm run migrations   # Executa migrations pendentes
```

## 🐳 Comandos Docker Úteis

```bash
# Iniciar containers
docker compose up -d

# Ver logs
docker compose logs -f medusa

# Parar containers
docker compose down

# Rebuild completo
docker compose up --build --force-recreate

# Acessar o container
docker exec -it medusa-server sh

# Executar seed
docker exec medusa-server npx medusa seed -f ./data/seed.json

# Criar usuário admin
docker exec -it medusa-server npx medusa user -e admin@email.com -p senha123
```

## 🔍 Troubleshooting

**Problemas comuns?** → [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)

### Erro: "The server does not support SSL connections"

**Solução:** NÃO adicione `DATABASE_SSL` nas variáveis de ambiente. O SSL está desabilitado por padrão para Docker Compose.

[Ver solução detalhada →](./TROUBLESHOOTING.md#❌-erro-the-server-does-not-support-ssl-connections)

### Erro: "Local Event Bus installed"

**Solução:** Verifique se `REDIS_URL=redis://redis:6379`

[Ver solução detalhada →](./TROUBLESHOOTING.md#❌-erro-local-event-bus-installed)

### Container reiniciando constantemente

**Solução:** Verifique logs de todos os serviços (postgres, redis, medusa)

[Ver solução detalhada →](./TROUBLESHOOTING.md#❌-container-reiniciando-constantemente)

## 📚 Estrutura do Projeto

```
medusa-store/
├── data/
│   └── seed.json              # Dados de exemplo
├── build/                     # Admin dashboard buildado
├── uploads/                   # Arquivos de upload
├── docker-entrypoint.sh       # Script de inicialização
├── Dockerfile                 # Imagem Docker multi-stage
├── docker-compose.yml         # Orquestração local
├── medusa-config.js           # Configuração do Medusa
├── package.json               # Dependências
└── README.md                  # Este arquivo
```

## 🔐 Segurança

**IMPORTANTE**: Antes de colocar em produção:

1. ✅ Mude `JWT_SECRET` e `COOKIE_SECRET`
2. ✅ Configure CORS apropriado (remova `*`)
3. ✅ Use senhas fortes para PostgreSQL
4. ✅ Configure SSL/HTTPS
5. ✅ Revise permissões de usuários

## 📖 Documentação Oficial

- [Medusa Documentation](https://docs.medusajs.com/)
- [Admin API Reference](https://docs.medusajs.com/api/admin)
- [Store API Reference](https://docs.medusajs.com/api/store)

## 🐛 Problemas Conhecidos

### Event Bus Redis

Se aparecer "Local Event Bus installed", verifique:
1. Redis está rodando
2. `REDIS_URL` está correto
3. Plugin `@medusajs/event-bus-redis` está antes do cache

### Build do Admin

O admin precisa ser buildado antes do deploy:
- Localmente: `npm run build`
- Docker: Feito automaticamente no Dockerfile

## 🤝 Suporte

- [Discord Medusa](https://discord.gg/medusajs)
- [GitHub Issues](https://github.com/medusajs/medusa/issues)

## 📄 Licença

MIT License

---

**Desenvolvido com ❤️ usando Medusa.js**
