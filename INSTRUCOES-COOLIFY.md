# 🚀 INSTRUÇÕES FINAIS - Deploy no Coolify

## ✅ Status Atual
- ✅ Repositório GitHub: https://github.com/gabrielLAraujo/medusa-store
- ✅ Código commitado e sincronizado
- ✅ Domínio gerado: `salmon-goldfish-177562.hostingersite.com`
- ✅ Senhas seguras geradas

---

## 📋 PASSO A PASSO NO COOLIFY

### 1️⃣ Acessar o Painel do Coolify

Acesse seu painel do Coolify na Hostinger

---

### 2️⃣ Criar Novo Recurso

1. Clique em **`+ New Resource`** ou **`Add Resource`**
2. Selecione **`Public Repository`** (para repositórios GitHub públicos)
3. Ou **`Docker Compose`** se preferir

---

### 3️⃣ Conectar Repositório

**URL do Repositório:**
```
https://github.com/gabrielLAraujo/medusa-store.git
```

**Branch:** `main` ou `master`

**Arquivo Docker Compose:**
- Opção 1: `.coolify/docker-compose.yml` (recomendado para Coolify)
- Opção 2: `docker-compose.yml` (padrão)

---

### 4️⃣ Configurar Variáveis de Ambiente

Copie e cole estas variáveis no Coolify:

```env
# Database
POSTGRES_USER=medusa
POSTGRES_PASSWORD=qTaLiUQasazglXgbLJVIAXK2RwDiYTZR
POSTGRES_DB=medusa_db
DATABASE_URL=postgresql://medusa:qTaLiUQasazglXgbLJVIAXK2RwDiYTZR@postgres:5432/medusa_db

# Redis
REDIS_URL=redis://redis:6379

# Secrets (NÃO ALTERAR - já gerados com segurança)
JWT_SECRET=vvcLKOyCb31w27p4ebLnuWe4OXY8wHv8eKx+Oi8nqJU=
COOKIE_SECRET=SsNCK4xrGa3o5ogt3BsO4oKcFkvf5oGwBAVoTMVcoaw=

# CORS
STORE_CORS=https://salmon-goldfish-177562.hostingersite.com
ADMIN_CORS=https://salmon-goldfish-177562.hostingersite.com

# Node Environment
NODE_ENV=production
PORT=9000
```

---

### 5️⃣ Configurar Domínio

1. Na seção **Domains** do recurso criado
2. Adicione: `salmon-goldfish-177562.hostingersite.com`
3. **Ative SSL/HTTPS** (Let's Encrypt) ✅
4. Certifique-se de expor a porta **9000**

---

### 6️⃣ Configurações de Deploy

**Build Command:** (automático pelo Dockerfile)
```bash
npm ci && npm run build
```

**Start Command:** (já está no docker-compose)
```bash
npm run migration:run && npm start
```

**Health Check Endpoint:**
```
/health
```

---

### 7️⃣ Deploy! 🚀

1. Revise todas as configurações
2. Clique em **`Deploy`** ou **`Start`**
3. Acompanhe os logs em tempo real
4. Aguarde 3-5 minutos para o build completo

---

## 🔍 Monitorar o Deploy

No painel do Coolify, você verá:

1. **Build Logs** - Construção da imagem Docker
2. **Runtime Logs** - Execução da aplicação
3. **Status** - Running, Stopped, Error, etc.

### Logs importantes para observar:

```
✓ PostgreSQL healthy
✓ Redis healthy
✓ Migrations executed
✓ Server listening on port 9000
✓ Admin dashboard ready
```

---

## ✅ Verificar Deploy Bem-Sucedido

Após o deploy, teste:

### 1. Health Check
```bash
curl https://salmon-goldfish-177562.hostingersite.com/health
```

Deve retornar: `{"status":"ok"}`

### 2. API Store
```bash
curl https://salmon-goldfish-177562.hostingersite.com/store/products
```

### 3. Admin Dashboard

Acesse no navegador:
```
https://salmon-goldfish-177562.hostingersite.com/app
```

---

## 🔐 Primeiro Acesso ao Admin

**Criar usuário admin:**

No terminal do container no Coolify, execute:

```bash
npx medusa user -e admin@medusa.com -p SuaSenhaSegura123
```

Ou use as credenciais padrão (se existirem):
- **Email:** `admin@medusa-test.com`
- **Senha:** `supersecret`

⚠️ **ALTERE A SENHA IMEDIATAMENTE!**

---

## 🛠️ Troubleshooting

### ❌ Deploy falhou com erro de migrations

**Solução:**
```bash
# No terminal do container Coolify:
npm run migration:run
```

### ❌ Admin não carrega (404 ou tela branca)

**Solução:**
```bash
# Rebuild do admin:
npm run build
```

### ❌ Erro de CORS

Verifique se as variáveis de ambiente têm o domínio correto:
```env
STORE_CORS=https://salmon-goldfish-177562.hostingersite.com
ADMIN_CORS=https://salmon-goldfish-177562.hostingersite.com
```

### ❌ Containers não iniciam

Verifique os logs no Coolify:
- PostgreSQL precisa estar healthy primeiro
- Redis precisa estar healthy
- Depois o Medusa sobe

### ❌ Porta 9000 não acessível

Certifique-se de:
1. Porta 9000 está exposta no Coolify
2. Domínio está apontando para a porta correta
3. SSL está ativo

---

## 📱 URLs Finais

Após deploy bem-sucedido:

- 🏠 **Loja (frontend)**: https://salmon-goldfish-177562.hostingersite.com
- 🔐 **Admin Dashboard**: https://salmon-goldfish-177562.hostingersite.com/app
- 🔌 **API**: https://salmon-goldfish-177562.hostingersite.com/store
- ❤️ **Health Check**: https://salmon-goldfish-177562.hostingersite.com/health

---

## 🔄 Redeploy (atualizar aplicação)

Quando fizer mudanças no código:

1. Commit e push para o GitHub:
```bash
git add .
git commit -m "Update: descrição da mudança"
git push origin main
```

2. No Coolify:
   - Clique em **`Redeploy`** ou **`Restart`**
   - Ou configure webhook automático

---

## 🎯 Próximos Passos

- [ ] Testar todas as URLs acima
- [ ] Criar primeiro usuário admin
- [ ] Adicionar produtos de teste
- [ ] Configurar Stripe para pagamentos
- [ ] Personalizar o admin
- [ ] Adicionar categorias
- [ ] Conectar frontend (Next.js/Gatsby)

---

## 📞 Ajuda

- 📖 **Medusa Docs**: https://docs.medusajs.com
- 💬 **Medusa Discord**: https://discord.gg/medusajs  
- 🐳 **Coolify Docs**: https://coolify.io/docs
- 🐙 **Seu Repo**: https://github.com/gabrielLAraujo/medusa-store

---

**🎉 Boa sorte com o deploy! Sua loja está pronta para subir!**


