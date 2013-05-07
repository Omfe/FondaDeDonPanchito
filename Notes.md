
# FondaDeDonPanchito

## ToDos

### Server

* Meal CRUD
  * get all
  * get 1
  * post
  * put
  * delete


### Client

1. Crear clase FDDPMainViewController (con xib, hereda de UIViewController).
2. En el AppDelegate, en application:didFinishLaunchingWithOptions: declarar UINavigationController y FDDPMainViewController.
3. Borrar el comentario y sustituir con los siguientes 3 pasos.
4. Inicializar primero el mainViewController (initWithNibName:).
5. Inicializar el navigationController (initWithRootViewController:).
6. Al window setRootViewController: el navigationController.
7. Crear en Finder un folder que se llame "Model" (junto con el AppDelegate, main, en.lprj, Default.png, etc.)
8. Arrastrar ese folder a Xcode al mismo nivel del AppDelegate (adentro del grupo "FondaDeDonPanchito").
9. Click derecho en ese folder.
10. New File...
11. Nuevas clases que hereden de NSObject: FDDPItem, FDDPMeal, FDDPOrder, FDDPUser, FDDPClient (todas estas clases adentro del grupo/folder "Model").
