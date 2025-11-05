module.exports = {
  projectConfig: {
    // Redis connection
    redis_url: process.env.REDIS_URL || "redis://localhost:6379",
    
    // Database connection
    database_url: process.env.DATABASE_URL || "postgres://localhost/medusa-store",
    database_type: "postgres",
    
    // Store and Admin CORS
    store_cors: process.env.STORE_CORS || "http://localhost:8000",
    admin_cors: process.env.ADMIN_CORS || "http://localhost:7001,http://localhost:9000",
    
    // Database connection pool
    database_extra: {
      ssl: process.env.DATABASE_SSL === "true" ? { rejectUnauthorized: false } : false,
    },
    
    // JWT and Cookie secrets
    jwt_secret: process.env.JWT_SECRET || "supersecret",
    cookie_secret: process.env.COOKIE_SECRET || "supersecret",
  },
  
  plugins: [
    // Admin dashboard
    {
      resolve: "@medusajs/admin",
      options: {
        autoRebuild: false,
      },
    },
  ],
  
  modules: {},
  
  featureFlags: {
    product_categories: true,
    tax_inclusive_pricing: true,
  },
};

