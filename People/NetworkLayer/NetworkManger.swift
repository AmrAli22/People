//
//  NetworkManger.swift
//  People
//
//  Created by Amr Ali on 07/09/2023.
//

import Foundation
import Alamofire

class NetworkingManager {
    
    static func makeRequest(method: HTTPMethod, url: String, headers: HTTPHeaders? = nil,
                            params: [String: Any]? , encoding: ParameterEncoding = URLEncoding.default,
                            successHandler: @escaping (_ response: Data?)->(),
                            errorHandler: @escaping (_ error:ErrorResponse?)->()) {
        
        
        let reachability = NetworkReachabilityManager(host: url)
         
         if reachability?.isReachable == false {
             // Device is not connected to the internet
             let error = ErrorResponse(message: "No Internet Connection")
             errorHandler(error)
             return
         }
        
        var recievedHeaders = headers
        if recievedHeaders == nil {
            recievedHeaders = HTTPHeaders()
        }
        
        recievedHeaders?.add(name: "Accept", value: "text/plain")
                
        AF.request(url , method: method,parameters: params ?? [:], encoding: encoding, headers: recievedHeaders)
            .responseJSON(completionHandler: {  response in

                if response.response?.statusCode == 200 {
                    successHandler(response.data)
                    return
                } else {
                    if ((response.value as? [String : Any]) != nil){
                        let error = ErrorResponse(error: response.value as! [String : Any])
                        errorHandler(error)
                        return
                    }else{
                        let error = ErrorResponse(message: "Some Thing Went Wrong !")
                        errorHandler(error)
                        return
                    }
                }
            })
    }
}


