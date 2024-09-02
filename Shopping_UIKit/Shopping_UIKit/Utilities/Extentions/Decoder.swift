//
//  Decoder.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import Foundation

import Foundation

enum DecoderError: Error {
    case dataLoadingError(Error)
    case decodingError(Error)
}

class Decoder {
    private let jsonDecoder: JSONDecoder
    
    init() {
        self.jsonDecoder = JSONDecoder()
    }
    
    func decode<T: Decodable>(_ data: Data, as type: T.Type) -> Result<T, DecoderError> {
        do {
            let decodedObject = try jsonDecoder.decode(T.self, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(.decodingError(error))
        }
    }
}
