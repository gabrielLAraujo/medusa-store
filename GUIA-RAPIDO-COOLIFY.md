# 🚀 GUIA RÁPIDO - Deploy Medusa.js no Coolify

## 📦 O que foi preparado:
- ✅ Repositório Git criado
- ✅ Domínio gratuito gerado: **salmon-goldfish-177562.hostingersite.com**
- ✅ Docker Compose configurado
- ✅ Senhas seguras geradas
- ✅ Todos os arquivos prontos

---

## 🔑 SENHAS GERADAS (COPIE AGORA!)

```env
JWT_SECRET=vvcLKOyCb31w27p4ebLnuWe4OXY8wHv8eKx+Oi8nqJU=
COOKIE_SECRET=SsNCK4xrGa3o5ogt3BsO4oKcFkvf5oGwBAVoTMVcoaw=
POSTGRES_PASSWORD=qTaLiUQasazglXgbLJVIAXK2RwDiYTZR
```

---

## 📝 PASSO A PASSO NO COOLIFY

### 1️⃣ Criar repositório no GitHub/GitLab

**Opção A - GitHub (recomendado):**
```bash
# Acesse: https://github.com/new
# Crie um repositório chamado: medusa-store
# Não adicione README, .gitignore ou licença

# Depois rode:
cd /Users/gabrielaraujo/medusa-store
git remote add origin https://github.com/SEU_USUARIO/medusa-store.git
git branch -M main
git push -u origin main
```

**Opção B - Usar repositório local no Coolify:**
- Se seu Coolify tem acesso à sua máquina local via SSH

---

### 2️⃣ No painel do Coolify

1. **Novo Projeto:**
   - Clique em `+ New Resource`
   - Escolha `Docker Compose`

2. **Conectar Repositório:**
   - Cole a URL do seu repositório Git
   - Ou selecione "Local Repository" se aplicável

3. **Configurar Build:**
   - Docker Compose Path: `.coolify/docker-compose.yml`
   - Ou use o padrão: `docker-compose.yml`

---

### 3️⃣ Configurar Variáveis de Ambiente

No Coolify, adicione estas variáveis:

```env
# Database
POSTGRES_USER=medusa
POSTGRES_PASSWORD=qTaLiUQasazglXgbLJVIAXK2RwDiYTZR
POSTGRES_DB=medusa_db
DATABASE_URL=postgresql://medusa:qTaLiUQasazglXgbLJVIAXK2RwDiYTZR@postgres:5432/medusa_db

# Redis
REDIS_URL=redis://redis:6379

# Secrets
JWT_SECRET=vvcLKOyCb31w27p4ebLnuWe4OXY8wHv8eKx+Oi8nqJU=
COOKIE_SECRET=SsNCK4xrGa3o5ogt3BsO4oKcFkvf5oGwBAVoTMVcoaw=

# CORS
STORE_CORS=https://salmon-goldfish-177562.hostingersite.com
ADMIN_CORS=https://salmon-goldfish-177562.hostingersite.com

# Node
NODE_ENV=production
PORT=9000
```

---

### 4️⃣ Configurar Domínio

1. Na seção **Domains** do Coolify
2. Adicione: `salmon-goldfish-177562.hostingersite.com`
3. Ative SSL (Let's Encrypt) ✅

---

### 5️⃣ Deploy!

1. Clique em **Deploy** 🚀
2. Aguarde o build (pode levar 3-5 minutos)
3. Acompanhe os logs

---

## ✅ Após o Deploy

### Acessar a loja:
- **Admin**: https://salmon-goldfish-177562.hostingersite.com/app
- **API**: https://salmon-goldfish-177562.hostingersite.com/store
- **Health**: https://salmon-goldfish-177562.hostingersite.com/health

### Credenciais padrão:
- **Email**: admin@medusa-test.com
- **Senha**: supersecret

⚠️ **ALTERE IMEDIATAMENTE APÓS O PRIMEIRO LOGIN!**

---

## 🆘 Problemas?

### Erro: Migrations não rodaram
```bash
docker exec -it medusa-backend npm run migration:run
```

### Erro: Admin não carrega
Aguarde 1-2 minutos após o deploy para o build do admin finalizar

### Erro: CORS
Verifique se as variáveis STORE_CORS e ADMIN_CORS estão corretas

---

## 📚 Próximos Passos

1. [ ] Fazer primeiro login e alterar senha
2. [ ] Adicionar produtos
3. [ ] Configurar Stripe para pagamentos
4. [ ] Conectar frontend da loja
5. [ ] Configurar emails (SendGrid/Mailgun)

---

## 🔗 Links Úteis

- Documentação Medusa: https://docs.medusajs.com
- Coolify Docs: https://coolify.io/docs
- Seu domínio: https://salmon-goldfish-177562.hostingersite.com

---

**🎉 Tudo pronto! Agora é só fazer o deploy no Coolify!**

