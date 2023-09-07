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
        
        var recievedHeaders = headers
        if recievedHeaders == nil {
            recievedHeaders = HTTPHeaders()
        }
        
        recievedHeaders?.add(name: "Accept", value: "text/plain")
        
        let ComputedUrl = APIUrlsConstants.APIMainURL + url
        
        AF.request(ComputedUrl , method: method,parameters: params ?? [:], encoding: encoding, headers: recievedHeaders)
            .responseJSON(completionHandler: {  response in
                
                print("URL:\(String(describing: response.request?.url))")
                print("Headers:\(String(describing: response.request?.headers))")
                print("Params:\(String(describing: params))")
                print("response:\(response)")

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


