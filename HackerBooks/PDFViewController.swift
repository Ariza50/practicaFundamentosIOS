//
//  PDFViewController.swift
//  HackerBooks
//
//  Created by Vicente Albert López on 5/2/17.
//  Copyright © 2017 Ariz Software, S.L. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {

    var book: Book
    
    @IBOutlet weak var visorPDF: UIWebView!
    
    var bookNofif : NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = book.title
        
        visorPDF.load(book.asyncPDF.data, mimeType: "application/pdf", textEncodingName: "utf8", baseURL:URL(string: "http://www.arizsystems.es")!)
    
        //  Nos susbribimos a las notificaciones
        suscribeNotif()
        
    }
    
    init(book: Book) {
        
        self.book = book
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }
    
    func cambioLibro(Notif: Notification){
        //  Si hemos llegado aquí es que se ha hecho click sobre algun libro de la LibraryTableViewController,
        //  Así que cojo el nuevo Book.
        if let bk = Notif.userInfo?["Libro"] as? Book {
            //  Lo guardo en mi modelo book
            self.book = bk
            //  Y luego actualizo los datos
            title = book.title
            visorPDF.load(book.asyncPDF.data, mimeType: "application/pdf", textEncodingName: "utf8", baseURL:URL(string: "http://www.arizsystems.es")!)
        }
    }
    
}

