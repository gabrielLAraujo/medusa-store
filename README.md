# Medusa Store - Coolify

Loja e-commerce com Medusa.js v1 configurada para deploy no Coolify.

## 🚀 Deploy no Coolify

### Variáveis de Ambiente Necessárias:

```bash
# Secrets (gere com: openssl rand -base64 32)
JWT_SECRET=seu-jwt-secret-aqui
COOKIE_SECRET=seu-cookie-secret-aqui

# PostgreSQL
POSTGRES_USER=medusa
POSTGRES_PASSWORD=sua-senha-segura
POSTGRES_DB=medusa

# CORS (substitua pelo seu domínio)
STORE_CORS=http://seu-dominio.com
ADMIN_CORS=http://seu-dominio.com

# Porta (opcional, padrão: 9000)
PORT=9000
```

### Passos:

1. Configure as variáveis de ambiente no Coolify
2. Faça o deploy
3. Aguarde a build e inicialização
4. Acesse: `http://seu-dominio.com/app` (Admin)

## 📦 Estrutura

- **Backend**: Medusa.js v1.20.6
- **Admin**: Dashboard integrado
- **Database**: PostgreSQL 15
- **Cache**: Redis 7
- **Plugins**: Payment Manual + Fulfillment Manual

## 🔧 Desenvolvimento Local

```bash
npm install
npm run dev
```

Acesse:
- Admin: http://localhost:9000/app
- API: http://localhost:9000

## 📝 Credenciais Padrão

- Email: `admin@medusa.com`
- Senha: `supersecret`

**⚠️ Altere após primeiro login!**

