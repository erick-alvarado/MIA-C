const controller = {};
const fs = require('fs');
const model = fs.readFileSync('././database/model.sql').toString();
const dataArr = model.toString().split(';');
dataArr.pop();


controller.list = (req,res)=>{
    req.getConnection((err,conn)=>{
        conn.query('SELECT * FROM hospital', (err,rows)=>{
            if(err){
                res.json(err);
            }
            console.log(rows);
            res.render('hospital');
        });

    });
};
controller.cargarModelo = (req,res)=>{
    req.getConnection((err,conn)=>{
        dataArr.forEach((query) => {
            conn.query(query+';', (err,rows)=>{
                if(err){
                    res.json(err);
                }
            });
        });
        res.render('hospital');

    });
};

controller.eliminarModelo = (req,res)=>{
    req.getConnection((err,conn)=>{
        const q = 'DROP TABLE hospital,asociado,tratamiento,victima,detalle_asociado,detalle_tratamiento,ubicacion,contacto;'
        conn.query(q, (err,rows)=>{
            if(err){
                res.json(err);
            }
        });
        console.log('Termino de eliminar');
        res.render('hospital');
    });
};


module.exports = controller;