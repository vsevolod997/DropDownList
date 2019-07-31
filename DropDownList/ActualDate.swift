//
//  ActualDateLoadet.swift
//  DropDownList
//
//  Created by Всеволод Андрющенко on 30/07/2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import Foundation

class ActualDate{
    private var array  = [String]()
    private let qeue = DispatchQueue(label: "label",attributes: .concurrent)
    
    public func append(_ value: String){
        qeue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public var valueDateArray:  [String] {
        var result = [String]()
        qeue.sync {
            result = array
        }
        return result
    }
    
}
