import User from "../models/authModel.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import PreviousDonations from "../models/previous_donation_model.js";

const createToken = (id, email, secretkey, expire) => {
  return jwt.sign({ id: id, email: email }, secretkey, {
    expiresIn: `${expire}`,
  });
};

const AuthService = {
  async registerUser({
    email,
    password,
    username,
    district,
    nearest_city,
    blood_group,
    phone_number,
    profile_url,
  }) {
    const existingUser = await User.findByEmail(email);
    if (existingUser) throw new Error("User already exists");
    return await User.create({
      email,
      password,
      username,
      district,
      nearest_city,
      blood_group,
      phone_number,
      profile_url,
    });
  },

  async previousDonations({ user_id, date, place }) {
    return await PreviousDonations.create({ user_id, date, place });
  },

  async loginUser({ email, password }) {
    const user = await User.findByEmail(email);
    const previousDonations = await PreviousDonations.findByUserId(user.id);
    if (!user) throw new Error("Invalid credentials");

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) throw new Error("Invalid credentials");

    const access_token = createToken(
      user.id,
      user.email,
      process.env.JWT_SECRET,
      "1m"
    );
    const refresh_token = createToken(
      user.id,
      user.email,
      process.env.JWT_REFRESH_SECRET,
      "3m"
    );

    return {
      id: user.id,
      email: user.email,
      username: user.username,
      access_token: access_token,
      refresh_token: refresh_token,
      previous_donations: previousDonations,
      blood_group: user.blood_group,
      phone_number: user.phone_number,
      district: user.district,
      nearest_city: user.nearest_city,
      profile_url: user.profile_url,
    };
  },

  async refreshAccessToken(refreshToken) {
    try {
      // Verify refresh token
      const decoded = jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET);

      const newAccessToken = createToken(
        decoded.id,
        decoded.email,
        process.env.JWT_SECRET,
        "1m"
      );
      // Generate new access token

      return newAccessToken;
    } catch (error) {
      console.error(error);
      return null;
    }
  },
};

export default AuthService;
