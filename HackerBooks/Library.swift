//
//  Library.swift
//  HackerBooks
//
//  Created by Vicente Albert López on 2/2/17.
//  Copyright © 2017 Ariz Software, S.L. All rights reserved.
//

import Foundation


class Library {
    
    var library = MultiDictionary<Tag, Book>()
    
    //  La libreria recibe la URL donde está el JSON, y esta lo descarga y lo carga en libros.
    init(JSON: URL) {
        
       //  De momento vamos a suponer que me he descargado el JSON
        let datosJson = try! Data(contentsOf: Bundle.main.url(forResource: "books_readable", withExtension: "json")!)
        
        do{
            
        //  Cargo los diccionarios en un archivo desde el json
        let dictionaries = try JSONSerialization.jsonObject(with: datosJson, options: []) as? JSONArray
        
        //  Ahora en dictionaries tengo [JSONDictionary], es decir, un array de Dict
        //  Ahora voy a intentar decodificarlos mediante JSONProcessing
        for dict in dictionaries!{
            do{
                //  extraigo un libro del dict en curso
                let book = try decode(book: dict)
                //  recorro todos sus tags y le creo el par <libro, tag> correspondiente, tantas inserciones del libro en el dict como tags tenga.
                for tag in book.tags {
                    library.insert(value: book, forKey: tag)
                }
            }catch{
                print("Error al procesar \(dict)")
            }
        }
            
        }catch{
            print("Algo ha salido mal...")
        }
    }
    
    //  Cantidad de libros, sin repetirse
    var booksCount: Int {
        
        get {
            let count: Int = self.library.countUnique
            return count
        }
    }
    
    //  Cantidad de libros de una temática
    func bookCount(forTagName name: String) -> Int {
        
        let tag = Tag(nameTag: name)
        //  si no me devuelve un valor válido...
        guard let cbks = library[tag]?.count
        else {
            //  devuelvo un 0.
            return 0
        }
        return cbks
        //  return (library[tag]?.count)!
        
    }
    
    //  Array de libros para un Tag determinado
    func books(forTagName name: String) -> [Book]? {
        
        let tag = Tag(nameTag: name)
        guard let bks = library[tag]
            else {
                return nil
        }
        return bks.sorted()
        
    }
    
    func books(forTagName name: String, at: Int) -> Book? {
        
        //  Recojo en un array los libros para el tag...
        guard let bks = books(forTagName: name)
        else {
            return nil
        }
        //  Si hay libros en el tag y el indice es menor que elementos en el tag, devolverá algo.
        //  Es decir el indice tiene que estar entre 0 y bks.count - 1
        if (bks.count>0 && at<bks.count) {
            let bk = bks[at]
            return bk
        }else {
            return nil
        }
        
        /*
        guard let bk = bks[at]
        else {
            return nil
        }
        */
    }
    
    //  Array de tags ordenados
    func tags() -> [Tag] {
        
        return library.keys.sorted()
    }
    
}
