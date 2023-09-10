//
//  userDefaultsHelper.swift
//  People
//
//  Created by Amr Ali on 10/09/2023.
//

import Foundation
class UserDefaultsHelper {
    
    // Function to save an array of objects to UserDefaults
    static func savePeople(_ people: [Person]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(people) {
            UserDefaults.standard.set(encoded, forKey: "PeopleKey")
        }
    }
    
    // Function to retrieve an array of objects from UserDefaults
    static func getPeople() -> [Person]? {
        if let savedData = UserDefaults.standard.data(forKey: "PeopleKey") {
            let decoder = JSONDecoder()
            if let people = try? decoder.decode([Person].self, from: savedData) {
                return people
            }
        }
        return nil
    }
}
