module.exports = {
  projectConfig: {
    // Redis URL
    redis_url: process.env.REDIS_URL || "redis://localhost:6379",
    
    // Database
    database_url: process.env.DATABASE_URL || "postgres://localhost/medusa-store",
    database_type: "postgres",
    
    // CORS
    store_cors: process.env.STORE_CORS || "http://localhost:8000",
    admin_cors: process.env.ADMIN_CORS || "http://localhost:7001,http://localhost:9000",
    
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
        develop: {
          open: process.env.OPEN_BROWSER !== "false",
        },
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
    
    // Event Bus com Redis
    {
      resolve: `@medusajs/event-bus-redis`,
      options: {
        redisUrl: process.env.REDIS_URL || "redis://localhost:6379",
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

