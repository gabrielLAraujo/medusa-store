FROM node:18-alpine AS base

# Dependências do sistema
FROM base AS deps
RUN apk add --no-cache libc6-compat python3 make g++
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

# Criar diretório de uploads
RUN mkdir -p /app/uploads && chown -R medusa:nodejs /app/uploads

USER medusa

EXPOSE 9000 7001

# Usar medusa start diretamente com host 0.0.0.0
CMD ["npx", "medusa", "start"]

