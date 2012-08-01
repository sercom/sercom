Para configurar la DB. es necesario haber utilizado los archivos de configuración para poder acceder al modelo de objetos. Una vez cumplido este requisito, seguir los siguientes pasos:

1 - crear la database y entregar acceso al usuario. A tal fin correr la siguiente línea:
echo 'CREATE DATABASE <USUARIO>; GRANT ALL PRIVILEGES ON <DATABASE>.* TO <USUARIO>@localhost IDENTIFIED BY '\''<PASSWORD>'\''; FLUSH PRIVILEGES;' | mysql -u root -p<ROOT_PASSWORD>

2 - inicializar el schema de la database. Utilizar el archivo provisto a tal fin:
mysql <DATABASE> -u <USUARIO> -p<PASSWORD> < sercom.schema.sql

3 - cargar los datos de inicio. Correr el administrador de TG utilizando el archivo de configuración apuntando a la database:
cd ../..
tg-admin --config=prod.cfg shell < doc/02.database_setup/data_initialize.py 
