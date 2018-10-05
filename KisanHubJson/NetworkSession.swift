//
//  NetworkSession.swift
//  KisanHub
//
//  Created by Nikhil Modi on 9/26/18.
//  Copyright © 2018 Nikhil Modi. All rights reserved.
//

import Foundation
class NetworkSession {
    var successBlock : (Data,String,String) -> Void
    var failureBlock:(Error,String,String) -> Void
    var commonUIBlock:(() -> Void)? = nil
    init(success:@escaping (Data,String,String)->Void , andFailure failure:@escaping (Error,String,String )->Void, andCommonUI common: (()->(Void) )?){
        self.successBlock = success
        self.failureBlock = failure
        self.commonUIBlock = common
    }
    func setUpGetRequest(urlString:String){
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: URL(string:urlString)!, completionHandler: { data, urlResponse, error in
            if let composeData = data {
                self.successBlock(composeData, urlString, "")

            }
            else if let composeError = error  {
                self.failureBlock(composeError,urlString,"")
            }
            DispatchQueue.main.async {
                self.commonUIBlock?()
            }
            
            }).resume()
    }
}
