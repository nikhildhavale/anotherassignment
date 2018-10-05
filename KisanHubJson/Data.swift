//
//  Data.swift
//  KisanHubJson
//
//  Created by Nikhil Modi on 9/28/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import Foundation
class DataItem:Codable,CustomStringConvertible{
    var description: String {
        var stringToReturn = ""
        if title != nil {
            stringToReturn += title!
        }
        return stringToReturn

    }
    
    var title:String?
    var status:Int?
    
}
