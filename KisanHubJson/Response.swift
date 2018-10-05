//
//  Response.swift
//  KisanHubJson
//
//  Created by Nikhil Modi on 9/28/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//

import Foundation
class Response<T:Codable>:Codable {
    var count:Int?
    var total_count:Int?
    var data:[T]?
    
    
}
