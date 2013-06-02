
# FondaDeDonPanchito

## ToDos

### Server

* 


### Client

* Order
  * Agregar (declarar + implementar) método público "updateFromDictionary:" que hace lo mismo que el de User (pero con las propiedades correspondientes).
* WebServicesManager
  * Importar la clase Order.
  * Adentro del completionHandler del NSURLConnection, declarar "orders" de tipo NSMutableArray y mandar eso al completion en vez de responseDictionary[@"message"].
  * Adentro del completionHandler declarar "order" de tipo FDDPOrder.
  * Adentro del completionHandler, después del primer if y antes del segundo if: hacer un forin para iterar los diccionarios adentro del arreglo responseDictionary[@"orders"]. Teniendo en mente que el servidor nos manda un hash con un arreglo de hashes, y un mensaje (que no nos interesa).
  * Dentro del forin, inicializar "order", y mandarle llamar updateFromDictionary:, y pasarle el diccionario del forin. Luego agregar ese order al arreglo "orders".
  * Antes del forin, inicializar el arreglo "orders".
* OrdersViewController
  * Terminar todo el código de cellForRowAtIndexPath:
  * Inicializar webServicesManager en fetchAllOrders.
  * En fetchAllOrders, adentro del completionBlock asignar orders a ordersArray y hacer reloadTable.
  * Importar OrderEditViewController.
  * En addNewOrder:, declarar, inicializar, y hacer push a un orderEditViewController.


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

