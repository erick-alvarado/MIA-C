const controller = {};
const { RSA_NO_PADDING } = require('constants');
const fs = require('fs');

const model = fs.readFileSync('././database/model.sql').toString();
const temporal = fs.readFileSync('././database/temporal.sql').toString();
const insert = fs.readFileSync('././database/insert.sql').toString();

var csv = fs.readFileSync('././csv/prueba.csv').toString();
csv = csv.replace('\n',';');

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
        conn.query("DELETE FROM temporal WHERE nombre_victima='NOMBRE_VICTIMA';", (err,rows)=>{
            if(err){
                res.json(err);
            }
        });
        //obtenerDatosTemporal
        conn.query('select * from temporal;', (err,rows)=>{
            if(err){
                res.json(err);
            }
            rows.forEach((data) => {
                //insertar hospital si no existe
                var q = "INSERT INTO hospital (nombre, direccion) SELECT * FROM (SELECT 'h.name', 'h.dir') AS tmp WHERE NOT EXISTS ( SELECT nombre FROM hospital WHERE nombre = 'h.name') LIMIT 1;";
                q= q.replace("h.name",data.nombre_hospital);
                q= q.replace("h.name",data.nombre_hospital);
                q= q.replace("h.dir",data.direccion_hospital);
                console.log(q);
                if(data.nombre_hospital!='' && data.direccion_hospital!=''){
                    conn.query(q,(err,rows)=>{
                        if(err){
                            res.json(err);
                        }
                    });
                }
                
            });
            conn.query('select * from hospital;',(err,rows)=>{
                if(err){
                    res.json(err);
                }
                else{
                    res.send(rows);
                }
            });
        });
    });
};
controller.cargarTemporal = (req,res)=>{
    
    req.getConnection((err,conn)=>{
        //crearTemporal
        conn.query(temporal, (err,rows)=>{
            if(err){
                res.json(err);
            }
        });
        
        //cargarTemporal
        var q = "LOAD DATA LOCAL INFILE '/home/ubuntu/Desktop/practica/csv/prueba.csv' INTO TABLE temporal FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n'; ;";
        conn.query(q, (err,rows)=>{
            if(err){
                res.json(err);
            }
            else{
                res.send(rows);
            }
        });
    });
};

controller.eliminarModelo = (req,res)=>{
    req.getConnection((err,conn)=>{
        const q = 'DROP TABLE hospital,asociado,tratamiento,victima,detalle_asociado,detalle_tratamiento,ubicacion,contacto;'
        conn.query(q, (err,rows)=>{
            if(err){
                res.json(err);
            }
            else{
                res.send(rows);
            }
        });
    });
};

controller.eliminarTemporal = (req,res)=>{
    req.getConnection((err,conn)=>{
        const q = 'DROP TABLE temporal;'
        conn.query(q, (err,rows)=>{
            if(err){
                res.json(err);
            }
            else{
                res.send(rows);
            }
        });
    });
};

module.exports = controller;