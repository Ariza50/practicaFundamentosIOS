//
//  Tag.swift
//  HackerBooks
//
//  Created by Vicente Albert López on 2/2/17.
//  Copyright © 2017 Ariz Software, S.L. All rights reserved.
//

import Foundation

class Tag{
    
    let nameTag : String
    
    init(nameTag: String) {
        
        self.nameTag = nameTag
    }
    
    func proxyForHashing() -> Int {
        return nameTag.hashValue
    }
    
    func proxyForEquality() -> String{
        
        return "\(nameTag)"
    }
    
    func proxyForComparison() -> String{
        return proxyForEquality()
    }
}

//MARK: - Protocolo Hashable
extension Tag: Hashable {
    
    var hashValue : Int {
        get {
            return "\(self.nameTag)".hashValue
        }
    }
    
}

//MARK: - Protocolo Equatable
extension Tag: Equatable {
    
    static func ==(lhs: Tag, rhs: Tag) -> Bool {
        return lhs.nameTag == rhs.nameTag
    }
    
}

//MARK: - Comparable
extension Tag: Comparable {
    
    static func <(lhs: Tag, rhs: Tag) -> Bool {
        return lhs.nameTag < rhs.nameTag
    }
    
}

