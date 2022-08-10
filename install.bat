echo Instalador de la base de datos Universidad
echo Autor: Brian espinoza alarcon
echo 10 de agosto de 2022
sqlcmd -S. -E -i BdUniversidad.sql
sqlcmd -S. -E -i BdUniversidadPA.sql
echo Se ejecuto correctamente la base de datos
pause