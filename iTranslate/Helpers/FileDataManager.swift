//
//  FileManagerExtension.swift
//  iTranslate
//
//  Created by Sajeev on 3/9/20.
//  Copyright © 2020 iTranslate. All rights reserved.
//

import Foundation

class FileDataManager {
        
    class var directoryUrl: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func removeFileAt(path: String) {
        try? FileManager.default.removeItem(atPath: path)
    }
    
    static func moveFile(from path: URL, toPath: URL, completion: (Result<Bool,Error>) -> Void) {
        do {
            try FileManager.default.moveItem(at: path, to: toPath)
            completion(.success(true))
        }
        catch {
            completion(.failure(error))
        }
    }
}
