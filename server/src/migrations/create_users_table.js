

const createUsersTable = async (pool) => {
  try {
    const query = `
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(100) NOT NULL,
        username VARCHAR(50) UNIQUE NOT NULL,
        district VARCHAR(50) NOT NULL,
        nearest_city VARCHAR(50) NOT NULL,
        blood_group VARCHAR(10) NULL,
        phone_number VARCHAR(15) NULL,
        profile_url TEXT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `;
    await pool.query(query);
    console.log("✅ Users table created/exists");
    
  } catch (error) {
    console.error("❌ Error creating table:", error);
    
  }
};

export default createUsersTable; // Add this to execute the function
