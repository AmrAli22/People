//
//  HomeInteractor.swift
//  People
//
//  Created by Amr Ali on 07/09/2023.
//

import Foundation
import Alamofire

struct CreateContInteractor {
    
    //MARK: - Get People
    
    typealias PeopleComplation = (_ PeopleData: PersonModel?, _ error: ErrorResponse?) -> ()
    
    func getPeople(completion: @escaping PeopleComplation) {
        
        NetworkingManager.makeRequest(method: .get, url: APIUrlsConstants.APIMainURL, headers: nil, params: nil, encoding: URLEncoding.queryString) { data in
            
            do {
        
                let dataResponse: PersonModel = try JSONDecoder().decode(PersonModel.self, from: data!)
                completion(dataResponse, nil)
            } catch (let error) {
                let errorResponse = ErrorResponse(message: error.localizedDescription)
                completion(nil, errorResponse)
                return
            }
        } errorHandler: { error in
            completion(nil, error)
            return
        }
    }
}
