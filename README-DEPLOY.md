# Deploy da Loja Medusa.js no Coolify/Hostinger

## 🚀 Guia Rápido de Deploy

### Domínio Disponível
- **desenvolvereviver.com** (ativo até 2026-09-04)

### Pré-requisitos

1. **Variáveis de Ambiente** - Criar arquivo `.env` com:

```env
# Database (será configurado no Coolify)
DATABASE_URL=postgresql://usuario:senha@host:5432/medusa_db

# Redis (será configurado no Coolify)
REDIS_URL=redis://redis:6379

# Security - GERAR NOVOS SECRETS!
JWT_SECRET=$(openssl rand -base64 32)
COOKIE_SECRET=$(openssl rand -base64 32)

# CORS - Seu domínio
STORE_CORS=https://desenvolvereviver.com
ADMIN_CORS=https://desenvolvereviver.com,https://admin.desenvolvereviver.com

# Environment
NODE_ENV=production
```

2. **Gerar Secrets de Segurança**:
```bash
# JWT Secret
openssl rand -base64 32

# Cookie Secret
openssl rand -base64 32
```

### Opções de Deploy

#### Opção 1: Deploy via Docker Compose (Recomendado)

1. **No Coolify**, criar novo projeto
2. Escolher "Docker Compose"
3. Fazer upload do `docker-compose.yml`
4. Configurar variáveis de ambiente
5. Deploy!

#### Opção 2: Deploy via Dockerfile

1. **No Coolify**, criar novo projeto
2. Conectar repositório Git ou fazer upload
3. Coolify detectará o `Dockerfile` automaticamente
4. Configurar variáveis de ambiente
5. Deploy!

### Portas Utilizadas

- **9000**: Backend API Medusa
- **7001**: Admin Dashboard
- **5432**: PostgreSQL (interno)
- **6379**: Redis (interno)

### Após o Deploy

1. **Rodar migrations**:
```bash
npm run migration:run
```

2. **Criar usuário admin**:
```bash
npx medusa user -e admin@desenvolvereviver.com -p suasenha
```

3. **Seed de dados (opcional)**:
```bash
npm run seed
```

### Acessos

- **Loja**: https://desenvolvereviver.com
- **Admin**: https://desenvolvereviver.com/app (ou porta 7001)
- **API**: https://desenvolvereviver.com/store (Backend)

### Troubleshooting

**Erro de conexão com banco**:
- Verificar se DATABASE_URL está correto
- Verificar se PostgreSQL está rodando

**Admin não carrega**:
- Verificar ADMIN_CORS
- Rebuildar admin: `npm run build`

**Produtos não aparecem**:
- Rodar seed: `npm run seed`
- Verificar migrations: `npm run migration:run`

### Checklist Pré-Deploy

- [ ] Gerar JWT_SECRET
- [ ] Gerar COOKIE_SECRET  
- [ ] Configurar DATABASE_URL
- [ ] Configurar REDIS_URL
- [ ] Atualizar CORS com domínio correto
- [ ] Configurar PostgreSQL no Coolify
- [ ] Configurar Redis no Coolify
- [ ] Fazer upload do projeto
- [ ] Rodar migrations
- [ ] Criar usuário admin
- [ ] Testar acesso à loja e admin

---

## 🎯 Próximos Passos

1. **Pagamentos**: Descomentar Stripe no `medusa-config.js`
2. **Email**: Configurar plugin de email (SendGrid, Mailgun, etc)
3. **Storage**: Migrar de local para S3 ou similar
4. **Analytics**: Adicionar Google Analytics ou similar
5. **SEO**: Configurar meta tags e sitemap

