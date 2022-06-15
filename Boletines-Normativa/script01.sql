--Deshabilita permisos "Conocimiento" y "Notificación" definidos en la lista de seguridad de todas las categorías
UPDATE DCCATEGORYDOCROLE SET FGACCESSKNOW = 2, FGACCESSNOTIFY = 2

--Deshabilita permisos "Conocimiento" y "Notificación" definidos en la lista de seguridad de todos los documentos
UPDATE DCDOCACCESSROLE SET FGACCESSKNOW = 2, FGACCESSNOTIFY = 2