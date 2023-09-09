// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let personModel = try? JSONDecoder().decode(PersonModel.self, from: jsonData)

import Foundation

// MARK: - PersonModel
struct PersonModel: Codable {
    var results: [Person]?
    var info: Info?
}

// MARK: - Info
struct Info: Codable {
    var seed: String?
    var results, page: Int?
    var version: String?
}

// MARK: - Result
struct Person: Codable , Equatable {
    var gender: String?
    var name: Name?
    var location: Location?
    var email: String?
    var login: Login?
    var dob, registered: Dob?
    var phone, cell: String?
    var id: ID?
    var picture: Picture?
    var nat: String?
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id?.value == rhs.id?.value
       }
    
}

// MARK: - Dob
struct Dob: Codable {
    var date: String?
    var age: Int?
}


// MARK: - ID
struct ID: Codable {
    var name: String?
    var value: String?
}

// MARK: - Location
struct Location: Codable {
    var street: Street?
    var city, state, country: String?
    var postcode: Postcode?
    var coordinates: Coordinates?
    var timezone: Timezone?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    var latitude, longitude: String?
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Street
struct Street: Codable {
    var number: Int?
    var name: String?
}

// MARK: - Timezone
struct Timezone: Codable {
    var offset, description: String?
}

// MARK: - Login
struct Login: Codable {
    var uuid, username, password, salt: String?
    var md5, sha1, sha256: String?
}

// MARK: - Name
struct Name: Codable {
    var title, first, last: String?
}

// MARK: - Picture
struct Picture: Codable {
    var large, medium, thumbnail: String?
}
