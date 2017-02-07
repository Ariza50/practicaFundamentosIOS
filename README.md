Práctica de Vicente Albert López. Fundamentos IOS Swift

El ser o no favorito se indicará mediant una propiedad booleana de Book (isFavorite)....

...Es decir, esa información debe de persistir de alguna manera cuando se cierra la App y cuando se abre,

¿Como harías eso?
Yo lo he implementado de manera que cuando se marca un libro como favorito, lo añado al MultiDic,
le pido a la clase library(Book(forTagName...) que me devuelva un array con los elementos para el tag "Favoritos" y este lo guardo en la SandBox.
Cuando arranco la app compruebo si hay algun array guardado en memoria con libros favoritos y los cargo en consequencia añadiéndolos al MultiDic
¿Se te ocurre más de una forma de hacerlo?
Sería más óptimo hacer el guardado del array de favoritos un momento antes de cerrar la App, ya que solo lo haces una vez durante el uso de la App.
No lo he implementado así porque no he tenido coj...a hacer que entrara en el método applicationWillTerminate... o en el applicationDidEnterBackground de la clase AppDelegate, aun no he averiguado porque :(

Cuando cambia el valor de la propiedad isFavorite de un Book, la table deberá reflejar ese hecho
¿Como lo harías?¿Como enviarías información de un Book a un LibraryViewController?
Mediante notificaciones, a las cuales se inscribe LibraryViewController.
¿Se te ocurre más de una forma de hacerlo?
Mediante delegado, pero entonces LibraryViewController tendría que ser el delegado de todos y cada uno de los libros.
¿Cual te parece mejor?
Sin duda la que he usado, mediante notificaciones ya que simplifica mucho la claridad del código.
La clase Book tiene unas notificaciones que realizar y otra clase (LibraryViewController) se inscribe a ese tipo de notificaciones, no tiene que repasarse todos y cada uno de los libros para hacerse delegado. Además, si hubira otra clase interesada en ese tipo de notificaciones ya no podría hacerlo mediante Delegate.

...usa el método reloadData de .... ¿Es esto una aberración...?
el método reloadData solo realiza la carga de nuevos datos que estén en ese momento visualizandose.
¿Hay otra alternativa?
No se me ocurre otra ahora :(

Cuando el usuario cambia en la tabla el libro seleccionado, el pdfViewController debe de actualizarse, ¿Como lo harías?
mediante notificaciones, tanto el pdfViewController como el BookViewController están inscritos en las notificaciones correspondientes al click de la tabla LibraryViewController
