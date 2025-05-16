import AuthService from "../services/authService.js";

const authController = {
  async register(req, res, next) {
    try {
      const { email, password, username, district, nearest_city, blood_group, phone_number, profile_url,previous_donations } = req.body;
      console.log(blood_group);
      const user = await AuthService.registerUser({
        email,
        password,
        username,
        district,
        nearest_city,
        blood_group,
        phone_number,
        profile_url,
      });
      if (user !== null){
          previous_donations.forEach(async (donation) => {
            await AuthService.previousDonations({
              user_id: user.id,
              date: donation.date,
              place: donation.place,
            });
          });
      }
      res.status(201).json({
        success: true,
        data: { id: user.id, email: user.email, username: user.username },
      });
    } catch (error) {
      next(error);
    }
  },

  async login(req, res, next) {
    try {
      const { email, password } = req.body;
      const result = await AuthService.loginUser({ email, password });
      res.status(200).json({
        success: true,
        data: result,
      });
    } catch (error) {
      next(error);
    }
  },
  async refreshAccessToken(req, res) {
    try {
      var { refreshToken } = req.body;
      //const refreshToken = reqToken.replace("Bearer ", "");
      refreshToken = refreshToken.split(" ")[1];

      if (!refreshToken) {
        return res.status(400).json({ message: "Refresh token is required" });
      }

      const newAccessToken = await AuthService.refreshAccessToken(refreshToken);

      if (!newAccessToken) {
        return res
          .status(403)
          .json({ message: "Invalid or expired refresh token" });
      }

      res.json({ accessToken: newAccessToken });
    } catch (error) {
      console.log(error);
      res
        .status(500)
        .json({ message: "Internal server error", error: error.message });
    }
  },
};

export default authController;
