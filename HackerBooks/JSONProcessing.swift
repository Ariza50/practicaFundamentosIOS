//
//  JSONProcessing.swift
//  HackerBooks
//
//  Created by Vicente Albert López on 4/2/17.
//  Copyright © 2017 Ariz Software, S.L. All rights reserved.
//

import Foundation

/*
 {
 "authors": "Allen B. Downey",
 "image_url": "http://hackershelf.com/media/cache/97/bf/97bfce708365236e0a5f3f9e26b4a796.jpg",
 "pdf_url": "http://greenteapress.com/compmod/thinkcomplexity.pdf",
 "tags": "programming, python, data structures",
 "title": "Think Complexity"
 }
 */

//MARK: - Aliases
typealias JSONObject        =   AnyObject
typealias JSONDictionary    =   [String : JSONObject]
typealias JSONArray         =   [JSONDictionary]

//MARK: - Decodification
func decode(book json: JSONDictionary) throws -> Book{
    
    // Validamos el diccionario
    guard let titleString = json["title"] as? String
        else{
            // la pringamos
            throw BooksError.wrongURLFormatForJSONResource
    }
    
    guard let imageString = json["image_url"] as? String,
        let imageURL = URL(string:imageString) else{
            // la pringamos
            throw BooksError.wrongURLFormatForJSONResource
    }
    
    guard let PdfString = json["pdf_url"] as? String,
        let PdfURL = URL(string:PdfString)  else{
            throw BooksError.resourcePointedByURLNotReachable
    }
    
    let authorsString = json["authors"] as? String
    let authorsArray = authorsString?.components(separatedBy: ", ")
    let authorSet = Set(authorsArray! as [String])
    

    let tagsString = json["tags"] as? String
    let tagsArray = tagsString?.components(separatedBy: ", ")
    var tagsSet = Set<Tag>() //Set(tagsArray! as [String])
    for c in tagsArray! {
        tagsSet.insert(Tag(nameTag: c))
    }
    
    
    return Book(title: titleString, authors: authorSet, tags: tagsSet, urlImage: imageURL, urlPDF: PdfURL)
    
}

func decode(starWarsCharacter json: JSONDictionary?) throws -> Book{
    
    guard let json = json else {
        throw BooksError.nilJSONObject
    }
    return try decode(starWarsCharacter: json)
    
}

