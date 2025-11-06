# 🔧 Troubleshooting - Medusa Store

Soluções para problemas comuns ao fazer deploy no Coolify.

## ❌ Erro: "The server does not support SSL connections"

### 🔍 Sintomas

```
Error: The server does not support SSL connections
    at Socket.<anonymous> (/app/node_modules/pg/lib/connection.js:76:37)
```

### 🎯 Causa

O Medusa está tentando conectar no PostgreSQL usando SSL, mas o PostgreSQL do Docker Compose **não tem SSL habilitado**.

### ✅ Solução

**Opção 1: Desabilitar SSL (Recomendado para Docker Compose)**

NÃO adicione a variável `DATABASE_SSL` nas configurações do Coolify.

Por padrão, o SSL está desabilitado se `DATABASE_SSL` não estiver definida.

**Opção 2: Habilitar SSL no PostgreSQL (Avançado)**

Se você realmente precisa de SSL:

1. Configure SSL no PostgreSQL
2. Adicione variável de ambiente no Coolify:
   ```env
   DATABASE_SSL=true
   ```

### ✅ Verificação

Após o fix, você deve ver nos logs:

```
✅ PostgreSQL is ready!
📦 Running migrations...
No migrations are pending
🎯 Starting Medusa server...
Server is ready on port: 9000
```

---

## ❌ Erro: "Local Event Bus installed"

### 🔍 Sintomas

```json
{"level":"warn","message":"Local Event Bus installed. This is not recommended for production."}
```

### 🎯 Causa

O Medusa não consegue conectar no Redis ou o plugin Event Bus está mal configurado.

### ✅ Solução

**1. Verifique se Redis está rodando:**

Nos logs do Coolify, procure pelo serviço `redis`:

```
Ready to accept connections tcp
```

**2. Verifique REDIS_URL:**

Deve ser exatamente:
```env
REDIS_URL=redis://redis:6379
```

**3. Verifique ordem dos plugins:**

No `medusa-config.js`, o Event Bus deve vir ANTES do Cache:

```javascript
plugins: [
  // Event Bus PRIMEIRO
  {
    resolve: `@medusajs/event-bus-redis`,
    options: {
      redisUrl: process.env.REDIS_URL,
    },
  },
  
  // Cache DEPOIS
  {
    resolve: `@medusajs/cache-redis`,
    options: {
      redisUrl: process.env.REDIS_URL,
    },
  },
]
```

---

## ❌ Container Reiniciando Constantemente

### 🔍 Sintomas

O container do Medusa reinicia a cada poucos segundos.

### 🎯 Causas Possíveis

1. PostgreSQL não está pronto
2. Redis não está pronto
3. Erro na conexão do banco
4. Variáveis de ambiente incorretas

### ✅ Solução

**1. Verifique logs de todos os serviços:**

- `postgres`: Deve mostrar "ready to accept connections"
- `redis`: Deve mostrar "Ready to accept connections tcp"
- `medusa`: Veja o erro específico

**2. Verifique health checks:**

O docker-compose tem health checks. Verifique se estão passando:

```bash
docker compose ps
```

Deve mostrar `(healthy)` para todos os serviços.

**3. Verifique variáveis de ambiente:**

Certifique-se que:
- `DATABASE_URL` está correta
- `REDIS_URL=redis://redis:6379`
- Senha do PostgreSQL corresponde em `POSTGRES_PASSWORD` e `DATABASE_URL`

---

## ❌ Admin não Carrega (404 ou Blank Page)

### 🔍 Sintomas

- `/app` retorna 404
- Página em branco
- Erro no console do browser

### 🎯 Causa

O build do admin não foi gerado ou não foi copiado corretamente.

### ✅ Solução

**1. Verifique se o build existe:**

Nos logs do Medusa, procure por:

```
📋 Files in /app:
drwxr-xr-x    1 medusa   nodejs        4096 build
```

Se não tiver `build/`, o admin não foi buildado.

**2. Force rebuild:**

No Coolify:
1. Clique em **"Stop"**
2. Clique em **"Force Rebuild"**
3. Aguarde o deploy

**3. Verifique configuração do admin:**

No `medusa-config.js`:

```javascript
{
  resolve: "@medusajs/admin",
  options: {
    autoRebuild: false,
    serve: true,
    path: "/app",
    outDir: "build",
  },
}
```

---

## ❌ Erro: "PostgreSQL is unavailable - sleeping"

### 🔍 Sintomas

Container do Medusa fica preso esperando PostgreSQL:

```
⏳ Waiting for PostgreSQL...
PostgreSQL is unavailable - sleeping
```

### 🎯 Causa

PostgreSQL não iniciou ou credenciais incorretas.

### ✅ Solução

**1. Verifique logs do PostgreSQL:**

Procure por:
```
database system is ready to accept connections
```

**2. Verifique credenciais:**

Certifique-se que são as mesmas em:
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `POSTGRES_DB`
- `DATABASE_URL` (deve usar mesmas credenciais)

**3. Teste conexão manual:**

```bash
docker compose exec postgres psql -U medusa -d medusa
```

---

## ❌ Erro: "Redis is unavailable - sleeping"

### 🔍 Sintomas

```
⏳ Waiting for Redis...
Redis is unavailable - sleeping
```

### 🎯 Causa

Redis não iniciou ou não está acessível.

### ✅ Solução

**1. Verifique logs do Redis:**

Procure por:
```
Ready to accept connections tcp
```

**2. Verifique network:**

Redis e Medusa devem estar na mesma network (`medusa-network`).

**3. Teste conexão:**

```bash
docker compose exec medusa ping redis
```

---

## ❌ Migrations Falhando

### 🔍 Sintomas

```
📦 Running migrations...
Error: [algum erro de migration]
```

### 🎯 Causa

Banco de dados com schema incompatível ou corrompido.

### ✅ Solução

**Opção 1: Reset do banco (⚠️ APAGA TODOS OS DADOS!)**

```bash
docker compose down -v
docker compose up -d
```

**Opção 2: Rodar migrations manualmente:**

```bash
docker compose exec medusa npx medusa migrations run
```

**Opção 3: Ver migrations pendentes:**

```bash
docker compose exec medusa npx medusa migrations show
```

---

## 🆘 Comandos Úteis para Debug

### Ver logs em tempo real

```bash
# Todos os serviços
docker compose logs -f

# Apenas Medusa
docker compose logs -f medusa

# Apenas PostgreSQL
docker compose logs -f postgres

# Apenas Redis
docker compose logs -f redis
```

### Status dos containers

```bash
docker compose ps
```

### Entrar no container

```bash
# Container do Medusa
docker compose exec medusa sh

# Container do PostgreSQL
docker compose exec postgres sh

# Container do Redis
docker compose exec redis sh
```

### Testar conectividade

```bash
# Do Medusa para PostgreSQL
docker compose exec medusa ping postgres

# Do Medusa para Redis
docker compose exec medusa ping redis
```

### Reiniciar serviço específico

```bash
docker compose restart postgres
docker compose restart redis
docker compose restart medusa
```

### Rebuild completo

```bash
docker compose down
docker compose build --no-cache
docker compose up -d
```

---

## 📞 Ainda com Problemas?

1. **Verifique documentação oficial:**
   - [Medusa Docs](https://docs.medusajs.com/)
   - [Coolify Docs](https://coolify.io/docs)

2. **Comunidade:**
   - [Discord Medusa](https://discord.gg/medusajs)
   - [GitHub Issues](https://github.com/medusajs/medusa/issues)

3. **Logs Completos:**
   - Sempre compartilhe logs completos ao pedir ajuda
   - Use `docker compose logs --tail=100 medusa`

---

## ✅ Checklist de Deploy Bem-Sucedido

- [ ] PostgreSQL mostra "ready to accept connections"
- [ ] Redis mostra "Ready to accept connections"
- [ ] Medusa mostra "✅ PostgreSQL is ready!"
- [ ] Medusa mostra "✅ Redis is ready!"
- [ ] Migrations executaram sem erro
- [ ] Server mostra "Server is ready on port: 9000"
- [ ] `/health` retorna `{"status":"ok"}`
- [ ] `/app` carrega o admin
- [ ] Sem "Local Event Bus" nos logs

Se todos os itens estão ✅, seu deploy está perfeito! 🎉

