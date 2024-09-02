//
//  BundleExtension.swift
//  EcommerceDemoApp
//
//  Created by Neosoft on 02/09/24.
//

import Foundation

extension Bundle {
    func load<T: Decodable>(_ fileName: String, withExtension fileExtension: String, as type: T.Type = T.self, using decoder: Decoder = Decoder()) -> Result<T, BundleError> {
        guard let url = self.url(forResource: fileName, withExtension: fileExtension) else {
            return .failure(.fileNotFound)
        }
        
        do {
            let data = try Data(contentsOf: url)
            switch decoder.decode(data, as: T.self) {
            case .success(let decodedObject):
                return .success(decodedObject)
            case .failure(let decoderError):
                return .failure(.decodingError(decoderError))
            }
        } catch {
            return .failure(.dataLoadingError(error))
        }
    }
}
