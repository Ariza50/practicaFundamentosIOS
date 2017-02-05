//
//  errors.swift
//  HackerBooks
//
//  Created by Vicente Albert López on 4/2/17.
//  Copyright © 2017 Ariz Software, S.L. All rights reserved.
//

import Foundation

enum BooksError : Error{
    case wrongURLFormatForJSONResource
    case resourcePointedByURLNotReachable
    case wrongJSONFormat
    case nilJSONObject
    case jsonParsingError
}
