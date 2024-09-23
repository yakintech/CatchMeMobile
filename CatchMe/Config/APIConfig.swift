//
//  APIConfig.swift
//  CatchMe
//
//  Created by Çağatay Yıldız on 23.09.2024.
//

import Foundation


struct APIConfig{
    
    static var baseURL: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "ApiUrl") as? String else {
          fatalError("Couldn't find key 'ApiUrl' in 'info.plist.plist'.")
        }
        return value
      }
    }
}
