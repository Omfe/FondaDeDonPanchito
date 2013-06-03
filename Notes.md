
# FondaDeDonPanchito

## ToDos

### Server

* 


### Client

* OrderEditorViewController
  * Agregar propiedad pública "order"
  * Declarar un bloque "completionBlock" (typedef) que no recibe nada
* OrdersViewController
  * En addNewOrder:, pasarle un completionBlock al orderEditorViewController.
  * Nuevo método privado "presentOrderEditorViewControllerWithOrder:" que recibe un FDDPOrder
    * Agarrar todo el código de addNewOrder: y ponerlo aquí
    * Asignar el order que nos están mandando al orderEditorViewController antes de asignar completionBlock
    * Adentro del completionBlock, mandar llamar a fetchAllOrders
  * En addNewOrder, mandar llamar al método presentOrderEditorViewControllerWithOrder:
  * En didSelectRowAtIndexPath: mandar llamar al método presentOrderEditorViewControllerWithOrder: y pasarle el order de la celda que seleccionaron


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

