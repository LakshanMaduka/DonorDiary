
const createDonationHistoryTable = async (pool) => {
    try {
      const query = `
        CREATE TABLE IF NOT EXISTS donation_history (
          id SERIAL PRIMARY KEY,
          user_id INT NOT NULL,
          date VARCHAR(25) NOT NULL,
          place VARCHAR(255) NOT NULL,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      `;
      await pool.query(query);
      console.log("✅ Donation_History table created/exists");

    } catch (error) {
      console.error("❌ Error creating table:", error);
   
    }
  };
  
  export default createDonationHistoryTable;