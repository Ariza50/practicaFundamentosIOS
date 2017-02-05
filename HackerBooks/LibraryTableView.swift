//
//  LibraryTableView.swift
//  HackerBooks
//
//  Created by Vicente Albert López on 2/2/17.
//  Copyright © 2017 Ariz Software, S.L. All rights reserved.
//

import UIKit

class LibraryTableView: UITableViewController {
    
    let library: Library
    
    var libraryNofif : NSObjectProtocol?
    
    init(library: Library) {
        
        self.library = library
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Nos susbribimos a las notificaciones
        suscribeNotif()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return library.tags().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return library.bookCount(forTagName: library.tags()[section].nameTag)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return library.tags()[section].nameTag
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellIdentifier = "BookCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)

        if cell == nil{
            // El opcional está vacio y toca crear
            // la celda desde cero
            cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: CellIdentifier)
        }
        
        //  Ahora busco el libro en cuestión
        let tag = library.tags()[indexPath.section]
        let bk = library.books(forTagName:tag.nameTag, at: indexPath.row)
        
        // Configurarla
        cell?.imageView?.image = UIImage(data: (bk?.asyncImage.data)!)
        cell?.textLabel?.text = bk?.title
        //  cell?.detailTextLabel?.text = bk?.authors

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //  Ahora busco el libro en cuestión
        let tag = library.tags()[indexPath.section]
        let bk = library.books(forTagName:tag.nameTag, at: indexPath.row)
        
        //  Si estamos corriendo en un iPad...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
        
            //  Creo un nombre de notificación para cuando se hace click sobre un libro
            let notif = Notification.Name(rawValue: "cambioLibro")
            //  Lo envio
            enviarNotificacion(nombre: notif, book: bk!)
        }
        //  Si estamos corriendo en un iPhone...
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            //  Aquí llamo al visor de pdf para que muestro el libro en el visor PDF.
            let pdfVC = BookViewController.init(book: bk!)
            navigationController?.pushViewController(pdfVC, animated: true)
        }
    }
    
    func  suscribeNotif() {
        
        //  Cogemos el handler del NofificationCenter
        let notifCenter = NotificationCenter.default
        let nombre = Notification.Name(rawValue: "imagenDescargada")
        libraryNofif = notifCenter.addObserver(forName: nombre, object: nil, queue: nil, using: actualizarPortada)
        //  Favoritos
        let notifFav = Notification.Name(rawValue: "Favoritos")
        libraryNofif = notifCenter.addObserver(forName: notifFav, object: nil, queue: nil, using: actualizarFavoritos)

    }
    
    func actualizarPortada(Notif: Notification){
        //  Si hemos llegado aquí es que se ha actualizado alguna Portada.
        self.tableView.reloadData()
        }
    
    func actualizarFavoritos(Notif: Notification){
        //  Así que cojo el nuevo Book.
        if let bk = Notif.userInfo?["Libro"] as? Book {
            //  Lo guardo en mi modelo book
            if (bk.tags.contains(Tag(nameTag: "Favoritos"))){
                //  Quito del multiDic el libro con el tag 'Favoritos'
                bk.tags.remove(Tag(nameTag: "Favoritos"))
                library.library.remove(value: bk, fromKey: Tag(nameTag: "Favoritos"))
            }else{
                //  Anado al multiDic el libro con su nuevo Tag
                bk.tags.insert(Tag(nameTag: "Favoritos"))
                library.library.insert(value: bk, forKey: Tag(nameTag: "Favoritos"))
            }
            //  Si hemos llegado aquí es que se ha actualizado alguna Portada.
            self.tableView.reloadData()
        }
        
        
    }
 
}

extension LibraryTableView {
    
    func  enviarNotificacion(nombre: Notification.Name, book: Book) {
        //  Cojo el handler del notification center
        let notifCenter = NotificationCenter.default
        //  Creo una notificación con el nombre de notificación asociado y envio el libro afectado
        let notif = Notification(name: nombre, object: self, userInfo: ["Libro":book])
        //  La envio
        notifCenter.post(notif)
    }
}
