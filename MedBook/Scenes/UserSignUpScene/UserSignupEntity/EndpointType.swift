//
//  EndpointType.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

protocol EndpointType {
    var path: String { get }
    var httpMethod: HTTPMethods { get }
}

extension EndpointType {
    func buildRequest() throws -> URLRequest {
        guard let url = URL(string: self.path) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        return request
    }
}

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
