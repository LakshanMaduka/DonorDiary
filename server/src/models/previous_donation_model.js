import { pool } from "../config/db.js";

const PreviousDonations = {
  async create({ user_id, date, place }) {
    const query = {
      text: "INSERT INTO donation_history(user_id, date, place) VALUES($1, $2, $3) RETURNING *",
      values: [user_id, date, place],
    };
    const result = await pool.query(query);
    return result.rows[0];
  },

  async findByUserId(user_id) {
    const query = {
      text: "SELECT * FROM donation_history WHERE user_id = $1",
      values: [user_id],
    };
    const result = await pool.query(query);
    return result.rows;
  }
};

export default PreviousDonations;
