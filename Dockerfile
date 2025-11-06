FROM node:18-alpine AS base

# Instalar dependências do sistema (incluindo netcat para healthcheck)
RUN apk add --no-cache libc6-compat python3 make g++ postgresql-client

# Dependências
FROM base AS deps
WORKDIR /app

# Instalar dependências
COPY package*.json ./
RUN npm install --production=false

# Build
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build do admin (cria pasta build/)
ENV NODE_ENV=production
RUN npm run build

# Produção
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 medusa

# Copiar arquivos necessários
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/build ./build
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/medusa-config.js ./
COPY --from=builder /app/docker-entrypoint.sh ./docker-entrypoint.sh
COPY --from=builder /app/data ./data

# Criar diretório de uploads
RUN mkdir -p /app/uploads && chown -R medusa:nodejs /app
RUN chmod +x /app/docker-entrypoint.sh

USER medusa

EXPOSE 9000 7001

# Usar script de entrada
CMD ["/app/docker-entrypoint.sh"]
