//
//  Models.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

// MARK: - Countries
struct CountryModel: Codable {
    let status: String
    let statusCode: Int
    let version, access: String
    let data: [String: Country]
    let countries: [Country]

    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status-code"
        case version, access, data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(String.self, forKey: .status)
        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
        self.version = try container.decode(String.self, forKey: .version)
        self.access = try container.decode(String.self, forKey: .access)
        self.data = try container.decode([String : Country].self, forKey: .data)
        self.countries = Array(data.values.sorted(by: {$0.country < $1.country}))
    }
}

struct Country: Codable {
    let country: String
    let region: Region
}

enum Region: String, Codable {
    case africa = "Africa"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case centralAmerica = "Central America"
}
