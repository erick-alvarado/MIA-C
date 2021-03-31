const controller = {};
const fs = require('fs');
const model = fs.readFileSync('././database/model.sql').toString();
const temporal = fs.readFileSync('././database/temporal.sql').toString();
var csv = fs.readFileSync('././csv/prueba.csv').toString();
csv = csv.replace('\n',';');
const dataArr = model.toString().split(';');
dataArr.pop();

var listaTemporal = csv.toString().split(';');

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
controller.cargarTemporal = (req,res)=>{
    
    req.getConnection((err,conn)=>{
        conn.query(temporal, (err,rows)=>{
            if(err){
                res.json(err);
            }
        });
        var q = '';
        for(var i = 23; i<listaTemporal.length; i++){
            q='INSERT INTO temporal (nombre_victima, apellido_victima ,direccion_victima ,fecha_primera_sospecha ,fecha_confirmacion ,fecha_muerte ,estado_victima ,nombre_asociado ,apellido_asociado ,fecha_conocio ,contacto_fisico ,fecha_inicio_contacto ,fecha_fin_contacto ,nombre_hospital ,direccion_hospital ,ubicacion_victima ,fecha_llegada ,fecha_retiro ,tratamiento ,efectividad ,fecha_inicio_tratamiento ,fecha_fin_tratamiento ,efectividad_victima )';
            q+=' values(';
            for(var j = 0;j<23;j++){
                try{
                    q+="'"+listaTemporal[i+j].toString();
                    if(listaTemporal[i+j]==''){
                        q+='null';
                    }
                }
                catch(Exception){
                    q+='null';
                }
                q+="'";
                if(j==22){
                    break;
                }
                q+=',';
            }
            q+=');';
            q.replace('\\','');
            conn.query(String.raw`${q}`, (err,rows)=>{
                if(err){
                    console.log(err);
                }
            });
            i+=22;
        }
        
        //res.render('hospital');

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