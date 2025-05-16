import { pool } from '../config/db.js';
import bcrypt from 'bcryptjs';

const User = {
  async create({email, password, username, district, nearest_city, blood_group, phone_number, profile_url}) {
    const hashedPassword = await bcrypt.hash(password, 10);
    const query = {
      text: 'INSERT INTO users(email, password, username, district, nearest_city, blood_group, phone_number, profile_url) VALUES($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *',
      values: [email, hashedPassword, username, district, nearest_city, blood_group, phone_number, profile_url],
    };
    const result = await pool.query(query);
    return result.rows[0];
  },

  async findByEmail(email) {
    const query = {
      text: 'SELECT * FROM users WHERE email = $1',
      values: [email],
    };
    const result = await pool.query(query);
    return result.rows[0];
  },
};

export default User;