# 📝 Changelog - Medusa Store

## [1.1.0] - 2025-11-06

### ✅ Melhorias Implementadas

#### 🔧 Configuração
- **medusa-config.js**: 
  - Reordenado plugins (Event Bus antes de Cache)
  - Adicionado `database_extra` para SSL
  - CORS configurado como `*` (ajustar em produção)
  - Admin configurado para servir build estático

#### 🐳 Docker
- **Dockerfile**:
  - Adicionado cópia do diretório `data/`
  - Melhorado permissões de arquivos
  - Otimizado multi-stage build

- **docker-compose.yml**: 
  - Criado para desenvolvimento local
  - Health checks para PostgreSQL e Redis
  - Volumes persistentes
  - Network isolado

- **docker-entrypoint.sh**:
  - Adicionado logs de debug detalhados
  - Verificação de versões Node/NPM
  - Verificação de diretório build
  - Logs de variáveis de ambiente (sem expor senhas)

#### 📚 Documentação
- **README.md**: 
  - Guia completo de desenvolvimento local
  - Instruções Docker Compose
  - Troubleshooting
  - Comandos úteis

- **COOLIFY_DEPLOY.md**: 
  - Guia passo-a-passo para Coolify
  - Configuração de variáveis de ambiente
  - Troubleshooting específico
  - Checklist de segurança

#### 🛠️ Scripts
- **develop.sh**: Script para modo desenvolvimento
- **healthcheck.sh**: Health check para Coolify
- **.dockerignore**: Otimização de build
- **.gitignore**: Arquivos ignorados no Git

### 🐛 Correções

#### Problema: "Local Event Bus installed"
- **Causa**: Event Bus Redis não inicializava corretamente
- **Solução**: Reordenado plugins no `medusa-config.js`

#### Problema: CORS bloqueando requests
- **Causa**: CORS restritivo
- **Solução**: Configurado `*` temporariamente (ajustar em produção)

#### Problema: Build do admin não encontrado
- **Causa**: Diretório `build/` não copiado corretamente
- **Solução**: Melhorado Dockerfile e adicionado verificação no entrypoint

### 🔐 Segurança

⚠️ **IMPORTANTE**: Antes de produção:
1. Gerar novos `JWT_SECRET` e `COOKIE_SECRET`
2. Configurar CORS específico
3. Usar senhas fortes no PostgreSQL
4. Habilitar HTTPS

### 📦 Dependências

Versões atuais:
- Node.js: 18+
- Medusa: 1.20.6
- PostgreSQL: 15
- Redis: 7

### 🚀 Como Atualizar

1. Faça pull das alterações:
   ```bash
   git pull origin main
   ```

2. Reconstrua a imagem Docker:
   ```bash
   docker compose up --build --force-recreate
   ```

3. Ou no Coolify, clique em **"Redeploy"**

### 📋 Próximos Passos

- [ ] Configurar CORS específico em produção
- [ ] Adicionar storefront Next.js
- [ ] Configurar backups automáticos
- [ ] Adicionar monitoramento (Sentry, etc)
- [ ] Configurar CI/CD
- [ ] Adicionar testes automatizados

---

## [1.0.0] - 2025-11-05

### 🎉 Versão Inicial

- Setup inicial do Medusa
- Configuração básica do Docker
- PostgreSQL e Redis configurados
- Admin dashboard integrado

