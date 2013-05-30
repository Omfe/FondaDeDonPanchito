
# FondaDeDonPanchito

## ToDos

### Server

* Implementar el método verifyLoggedIn del app.rb
  * Revisar en la base de datos que ese token exista, si no, mandar un error de response
* Utilizar el método de app.rb "verifyLoggedIn" al principio de todos los métodos en los otros archivos (menos en auth.rb)


### Client

* Crear AdminViewController
* En LoginViewController hacer un método privado que regrese un BOOL que se llame shouldShowAdminScreen
* En ese método, regresar YES si el loggedInUser es admin, NO si no
* En pushToRegistry usar ese método para saber si inicializar y agregarlo al arreglo de los controles del tabBarController


#### UI

* Login
* Register
  * Order
    * Meals & Items
  * Tendra tabs de las ordenes que se vayan abriendo y se le incluyen lo que se vaya pidiendo en esa orden
* Members
* Admin (hidden if user isn't Admin)


----

Ir a mesa
Anotar parte de orden
Ir a registro
Hacer Log in en ipod
abrir nuevo tab
agregar lo que se ah pedido
ej (escojer de seccion de bebidas, dos limonadas)
cada que se abra un nuevo tab, ingresar ID de mesero

