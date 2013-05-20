
# FondaDeDonPanchito

## ToDos

### Server

* CRUD para Auth
  * POST /register
* Agregar código a todas las rutas de Meal y Items para que requieran del token


### Client

* LoginViewController
  * Hacer el segundo TextField "secure" (que salgan bolitas cuando escribes) en Interface Builder.
* AuthenticationManager
  * Agregar propiedad privada nonatomic, strong, tipo NSString que se llame "token".
  * Asignar el token del response del login a esa propiedad
* Crear RegistryViewController
* LoginViewController
  * Hacer un método "_pushToRegistry" tipo void y no recibe nada
  * En ese método, declarar:
    * UITabBarController *tabBarController
    * FDDPRegistryViewController *registryViewController
  * Inicialiar los dos (primero el registry), al tabBarController (pasarle un arreglo que contiene al registry)
  * El LoginViewController pertenece a un NavigationController (ver AppDelegate para comprobar), por ende tiene una propiedad "navigationController", mandarle llamar pushViewController:anmiated: a esa propiedad, el primer parámetro que tenemos que mandar va a ser el tabBarController, YES animado


#### UI

* Login
* Register
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

