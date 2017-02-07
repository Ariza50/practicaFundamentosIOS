//
//  Book.swift
//  HackerBooks
//
//  Created by Vicente Albert López on 2/2/17.
//  Copyright © 2017 Ariz Software, S.L. All rights reserved.
//

import Foundation
    
class Book {
    
    static let defaultImageAsData = try! Data(contentsOf: Bundle.main.url(forResource: "book", withExtension: "png")!)
    static let defaultPDFAsData = try! Data(contentsOf: Bundle.main.url(forResource: "LogoP", withExtension: "png")!)
    
    //MARK: - Stored properties
    let title : String
    let authors : Set<String>
    var tags : Set<Tag>
    let asyncImage : AsyncData
    let asyncPDF : AsyncData
    
    //MARK: - Initialization
    init(title: String, authors: Set<String>, tags: Set<Tag>, urlImage: URL, urlPDF: URL) {
        
        self.title = title
        self.authors = authors
        self.tags = tags
        asyncImage = AsyncData(url: urlImage, defaultData: Book.defaultImageAsData)
        asyncPDF = AsyncData(url: urlPDF, defaultData: Book.defaultPDFAsData)
        
        //  Nos hacemos delegados de AsyncImage para que nos notifique cuando ha descargado cosas.
        asyncImage.delegate = self
        asyncPDF.delegate = self
    }
    
    func addFavoritos() {
        /*
        if (tags.contains(Tag(nameTag: "Favoritos"))){
            //  Quito el tag 'Favoritos' de mi lista de tags
            tags.remove(Tag(nameTag: "Favoritos"))
            }else {
                //  Me añado a mi mismo el tag 'Favoritos'
                tags.insert(Tag(nameTag: "Favoritos"))
            
            }
        */
        //  Notifico a quien le interese que libraries ha cambiado el estado de los favoritos
        let notif = Notification.Name(rawValue: "Favoritos")
        //  Lo envio
        enviarNotificacion(nombre: notif)
    }
    
}

extension Book: AsyncDataDelegate {
    
    func asyncData(_ sender: AsyncData, shouldStartLoadingFrom url: URL) -> Bool {
        // nos pregunta si puede haer la descarga.
        // por supuesto!
        return true
    }
    
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        
        if (sender == asyncImage){
            
            //  Aquí deberia llamar a mi delegado para que actualice la foto del pdf.
            //  creo un nombre de notificación
            let notif = Notification.Name(rawValue: "imagenDescargada")
            //  Lo envio
            enviarNotificacion(nombre: notif)
        }else {
            
            //  Aquí deberia llamar a mi delegado para que actualice el pdf.
            //  Creo un nombre de notificación para el pdf
            let notif = Notification.Name(rawValue: "cambioLibro")  //  le envio "cambioLibro" ya que el efecto sobre el visor es el mismo = recarga el UIWebView
            //  Lo envio
            enviarNotificacion(nombre: notif)
        }

    }
    
}

//MARK: - Notificaciones
extension Book {
    
    func  enviarNotificacion(nombre: Notification.Name) {
        //  Cojo el handler del notification center
        let notifCenter = NotificationCenter.default
        //  Creo una notificación con el nombre de notificación asociado y envio el libro afectado
        let notif = Notification(name: nombre, object: self, userInfo: ["Libro":self])
        //  La envio
        notifCenter.post(notif)
    }

}

//MARK: - Protocolo Hashable
extension Book: Hashable {
    
    var hashValue : Int {
        get {
            return "\(self.title)".hashValue
        }
    }

}

//MARK: - Protocolo Equatable
extension Book: Equatable {
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
    
}

//MARK: - Comparable
extension Book: Comparable {
    
    static func <(lhs: Book, rhs: Book) -> Bool {
        return lhs.title < rhs.title
    }
    
}






