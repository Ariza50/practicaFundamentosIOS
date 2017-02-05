//
//  BookViewController.swift
//  HackerBooks
//
//  Created by Vicente Albert López on 5/2/17.
//  Copyright © 2017 Ariz Software, S.L. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    var book: Book
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var nombresTags: UILabel!
    
    var bookNofif : NSObjectProtocol?

    init(book: Book) {
        
        self.book = book
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func openPDF(_ sender: Any) {
        
        //  Aquí llamo al visor de pdf para que muestro el libro en el visor PDF.
        let pdfVC = PDFViewController.init(book: book)
        navigationController?.pushViewController(pdfVC, animated: true)
    }
    
    @IBAction func favorito(_ sender: Any) {
        self.book.addFavoritos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = book.title
        titulo.text = book.title
        imageBook.image = UIImage(data: (book.asyncImage.data))
        nombresTags.text = book.tags.sorted().map{$0.nameTag}.joined(separator: ", ")
        
        //  Nos suscribimos a las notificaciones
        suscribeNotif()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  suscribeNotif() {
        
        //  Cogemos el handler del NofificationCenter
        let notifCenter = NotificationCenter.default
        let nombre = Notification.Name(rawValue: "cambioLibro")
        bookNofif = notifCenter.addObserver(forName: nombre, object: nil, queue: nil, using: cambioLibro)
        let notifFav = Notification.Name(rawValue: "Favoritos")
        bookNofif = notifCenter.addObserver(forName: notifFav, object: nil, queue: nil, using: cambioTag)
    }
    
    func cambioLibro(Notif: Notification){
        //  Si hemos llegado aquí es que se ha hecho click sobre algun libro de la LibraryTableViewController,
        //  Así que cojo el nuevo Book.
        if let bk = Notif.userInfo?["Libro"] as? Book {
            //  Lo guardo en mi modelo book
            self.book = bk
            //  Y luego actualizo los datos
            title = book.title
            titulo.text = book.title
            imageBook.image = UIImage(data: (book.asyncImage.data))
            nombresTags.text = book.tags.sorted().map{$0.nameTag}.joined(separator: ", ")
        }
    }
    
    func cambioTag(Notif: Notification){
        //  Si hemos llegado aquí es que se ha hecho click sobre algun libro de la LibraryTableViewController,
        //  Así que cojo el nuevo Book.
        if let bk = Notif.userInfo?["Libro"] as? Book {
            //  Lo guardo en mi modelo book
            self.book = bk
            //  Y luego actualizo los datos
            title = book.title
            titulo.text = book.title
            imageBook.image = UIImage(data: (book.asyncImage.data))
            nombresTags.text = book.tags.sorted().map{$0.nameTag}.joined(separator: ", ")
        }
    }

}
