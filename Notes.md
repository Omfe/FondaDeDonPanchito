
# FondaDeDonPanchito

## ToDos

### Server

* Implementar el método verifyLoggedIn del app.rb
  * Revisar en la base de datos que ese token exista, si no, mandar un error de response
* Utilizar el método de app.rb "verifyLoggedIn" al principio de todos los métodos en los otros archivos (menos en auth.rb)


### Client

* RegistryViewController
  * Declarar propiedades privadas:
    * weak, IBOutlet, UITableView, ordersTableView
    * strong, NSArray, ordersArray
  * Conformarse a UITableViewDelegate y UITableViewDataSource en la interfaz privada
  * Agregar un UITableView en el .xib
  * Conectar el delegate y dataSource al File's Owner
  * Implementar los métodos required del UITableViewDataSource
  * Implementar didSelectRowAtIndexPath: del UITableViewDelegate
* OrderViewController
* OrderEditorViewController
* MealEditorViewController
* ItemChooserViewController
* ItemEditorViewController


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

