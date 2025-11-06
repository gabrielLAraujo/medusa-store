# 🛍️ Medusa Store - E-commerce Headless

Loja e-commerce completa construída com [Medusa.js](https://medusajs.com/) - Plataforma headless de código aberto.

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

### 1. Configure as variáveis de ambiente no Coolify

**Obrigatórias:**
```env
NODE_ENV=production
DATABASE_URL=postgresql://user:password@host:5432/database
REDIS_URL=redis://redis:6379
JWT_SECRET=seu_secret_jwt_aqui
COOKIE_SECRET=seu_secret_cookie_aqui
```

**Opcionais:**
```env
STORE_CORS=https://seu-dominio.com
ADMIN_CORS=https://seu-dominio.com
```

### 2. Configure os serviços

O Coolify irá criar automaticamente:
- ✅ Container PostgreSQL
- ✅ Container Redis
- ✅ Container Medusa Server

### 3. Health Check

O Medusa estará rodando quando você ver nos logs:

```
🎯 Starting Medusa server...
Server is ready on port: 9000
```

### 4. Acesse o Admin

Após o deploy, acesse: `https://seu-dominio.com/app`

Credenciais padrão (se fez seed):
- Email: `admin@medusa-test.com`
- Senha: `supersecret`

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

### Erro: "Local Event Bus installed"

Verifique se a variável `REDIS_URL` está configurada corretamente:

```env
REDIS_URL=redis://redis:6379
```

### Erro ao conectar no PostgreSQL

Certifique-se que:
1. PostgreSQL está rodando
2. `DATABASE_URL` está correto
3. O health check do PostgreSQL passou

### Admin não carrega

Certifique-se que o build foi feito:

```bash
npm run build
```

### Porta 9000 já em uso

Mude a porta no `docker-compose.yml`:

```yaml
ports:
  - "9001:9000"  # Usa porta 9001 localmente
```

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
