--Actualiza (marca como ya ejecutadas) las tareas de conocimiento de publicación que pudieran haberse generado con configuraciones previas de documentos
UPDATE DCDOCUMENTUSER SET DTKNOWLEDGE = to_date('28/01/2022','DD/MM/YYYY')
WHERE FGKNOWLEDGE = 1
AND DTKNOWLEDGE IS NULL

--Indica al sistema que las notificaciones de documentos registrados ya fueron enviadas
UPDATE DCDOCUMENTUSER SET FGSENTNOTIFIY = 1