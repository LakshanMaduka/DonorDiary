import pkg from "pg";
const { Pool } = pkg;
import { config } from "dotenv";
import createUsersTable from "../migrations/create_users_table.js";
import createDonationHistoryTable from "../migrations/create_donation_history_table.js";

config();

// Create PostgreSQL pool configuration
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

const initializeDatabase = async () => {
  let client;
  try {
    // Test database connection
    client = await pool.connect();
    console.log("✅ Connected to the database successfully");
    
    // Create tables sequentially
    await createUsersTable(pool);
    await createDonationHistoryTable(pool);
    
    console.log("✅ Database initialized successfully");
  } catch (error) {
    console.error("❌ Database initialization failed:", error);
    process.exit(1);
  } finally {
    // Release client back to pool if connection was successful
    if (client) client.release();
  }
};

// Export pool and initialization function
export { pool, initializeDatabase };