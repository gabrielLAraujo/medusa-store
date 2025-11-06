module.exports = {
  projectConfig: {
    // Redis URL
    redis_url: process.env.REDIS_URL || "redis://localhost:6379",
    
    // Database
    database_url: process.env.DATABASE_URL || "postgres://localhost/medusa-store",
    database_type: "postgres",
    database_extra: 
      process.env.NODE_ENV !== "development"
        ? { ssl: { rejectUnauthorized: false } }
        : {},
    
    // CORS - Permite todas as origens em produção (ajustar depois)
    store_cors: process.env.STORE_CORS || "*",
    admin_cors: process.env.ADMIN_CORS || "*",
    
    // Secrets
    jwt_secret: process.env.JWT_SECRET || "supersecret",
    cookie_secret: process.env.COOKIE_SECRET || "supersecret",
  },
  
  plugins: [
    // Admin Dashboard
    {
      resolve: "@medusajs/admin",
      options: {
        autoRebuild: false,
        serve: true,
        path: "/app",
        outDir: "build",
        develop: {
          open: false,
        },
      },
    },
    
    // Event Bus com Redis (DEVE VIR ANTES DO CACHE)
    {
      resolve: `@medusajs/event-bus-redis`,
      options: {
        redisUrl: process.env.REDIS_URL || "redis://localhost:6379",
      },
    },
    
    // Cache com Redis
    {
      resolve: `@medusajs/cache-redis`,
      options: {
        redisUrl: process.env.REDIS_URL || "redis://localhost:6379",
        ttl: 30,
      },
    },
    
    // Fulfillment Manual (OBRIGATÓRIO)
    {
      resolve: `medusa-fulfillment-manual`,
    },
    
    // Payment Manual (OBRIGATÓRIO)
    {
      resolve: `medusa-payment-manual`,
    },
  ],
  
  modules: {},
  
  featureFlags: {
    product_categories: true,
    tax_inclusive_pricing: true,
  },
};

