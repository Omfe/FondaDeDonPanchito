
# FondaDeDonPanchito

## ToDos

### Server

* CRUD para Auth
  * POST /logout
    * En el body se va a mandar nomás el token
    * Query para buscar al usuario con ese token
    * Si el query regresó 0 usuarios, manda response de success (ya estaba logged out, mensaje "User was already logged out.")
    * El query debería regresar 1 user_hash si si estaba logged in
    * Hacer un UPDATE query para borrar el token de ese usuario (token='')
    * Regresar success (mensaje "Successfully logged out.")
    * Probar todo esto usando REST Client + Sequel Pro.
  * POST /register
* Agregar código a todas las rutas de Meal y Items para que requieran del token


### Client

* 

#### UI

* Login Screen
* Una vez determinado si es Admin o no, irse a la interfaz uno o dos tabs extras apareceran si es Admin, en todo lo demas son iguales
* Interfaz tener divisiones: Miembros, Registro y Admin (si es admin la opcion sera visible)
* Miembros - falta determinar
* Registro - tendra tabs de las ordenes que se vayan abriendo y se le incluyen lo que se vaya pidiendo en esa orden

----
Ir a mesa
Anotar parte de orden
Ir a registro
Hacer Log in en ipod
abrir nuevo tab
agregar lo que se ah pedido
ej (escojer de seccion de bebidas, dos limonadas)
cada que se abra un nuevo tab, ingresar ID de mesero


