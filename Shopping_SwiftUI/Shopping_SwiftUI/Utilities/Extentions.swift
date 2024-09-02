//
//  Extentions.swift
//  SwiftUIDemoProject
//
//  Created by Neosoft on 02/09/24.
//

import Foundation

extension Bundle {
    func load<T: Decodable>(_ fileName: String, withExtension fileExtension: String, as type: T.Type = T.self) -> Result<T, BundleError> {
        guard let url = self.url(forResource: fileName, withExtension: fileExtension) else {
            return .failure(.fileNotFound)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: data)
            return .success(decodedObject)
        } catch {
            // Check if the error is related to data loading or decoding
            if let _ = error as? URLError {
                return .failure(.dataLoadingError(error))
            } else {
                return .failure(.decodingError(error))
            }
        }
    }
}

