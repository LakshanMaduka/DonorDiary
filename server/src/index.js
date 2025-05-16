import express from 'express';
import authRoutes from './routes/authRoutes.js';
import errorMiddleware from './middlewares/errorMiddleware.js';
import { initializeDatabase } from './config/db.js';

const app = express();

initializeDatabase().then(() => {
  app.use(express.json());
  app.use('/api/auth', authRoutes);
  
  app.use(errorMiddleware);

  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
});