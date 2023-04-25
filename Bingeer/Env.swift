//
//  Env.swift
//  Bingeer
//
//  Created by Atdhe Boshnjaku on 4/25/23.
//

import Foundation

final class Env {
    static let shared = Env()
    private var env: [String: String] = [:]
    
    private init() {
        guard let url = Bundle.main.url(forResource: ".env", withExtension: nil) else {
            fatalError("Failed to locate .env file in the app bundle.")
        }
        
        do {
            let data = try String(contentsOf: url, encoding: .utf8)
            let lines = data.components(separatedBy: .newlines)
            
            for line in lines {
                let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if !trimmedLine.isEmpty && !trimmedLine.starts(with: "#") {
                    let components = trimmedLine.components(separatedBy: "=")
                    
                    if components.count == 2 {
                        let key = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                        let value = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                        env[key] = value
                    }
                }
            }
        } catch {
            fatalError("Failed to read .env file: \(error.localizedDescription)")
        }
    }
    
    func value(for key: String) -> String? {
        return env[key]
    }
}
