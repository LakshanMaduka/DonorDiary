const testController = {
    test: (req, res) => {    
        console.log(req.headers); 
        res.status(200).json({ message: 'Test controller works' });
    }
};
export default testController;