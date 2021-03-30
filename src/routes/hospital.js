const express = require('express');
const router = express.Router();
const hospitaController = require('../controllers/hospitalController');


router.post('/cargarModelo', hospitaController.cargarModelo);
router.post('/eliminarModelo', hospitaController.eliminarModelo);
router.get('/', hospitaController.list);

module.exports = router;