INSERT INTO hospital (nombre, direccion)
SELECT * FROM (SELECT 'h.name', 'h.dir') AS tmp
WHERE NOT EXISTS (
    SELECT nombre FROM hospital WHERE nombre = 'h.name'
) LIMIT 1;

