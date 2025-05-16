import express from 'express';
import authController from '../controllers/authController.js';
import testController from '../controllers/testController.js';
import tokenCheckMiddleware from '../middlewares/tokenCheckMiddleware.js';


const router = express.Router();

router.post('/register', authController.register);
router.post('/login', authController.login);
router.post('/refresh', authController.refreshAccessToken);
router.get('/test', tokenCheckMiddleware,testController.test);

export default router;
