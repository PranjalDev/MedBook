//
//  NetworkManager.swift
//  MedBook
//
//  Created by Pranjal Verma on 22/10/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case httpStatusError
}

class NetworkManager {
    
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder
    static let shared = NetworkManager()
    
    private init(urlSession: URLSession = URLSession.shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func request<Model: Decodable, EndPoint: EndpointType>(model: Model.Type, endpoint: EndPoint) async throws -> Model {
        do {
            // build request
            let request = try endpoint.buildRequest()
            
            let (data, resposne) = try await urlSession.data(for: request)
            guard let httpResponse = resposne as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { throw NetworkError.httpStatusError }
            
            // decoding response
            let decodedResponse = try jsonDecoder.decode(model.self, from: data)
            return decodedResponse
        } catch let error {
            throw error
        }
    }
}
