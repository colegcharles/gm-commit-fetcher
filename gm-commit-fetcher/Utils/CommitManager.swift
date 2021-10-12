//
//  CommitManager.swift
//  gm-commit-fetcher
//
//  Created by Cole Charles on 10/12/21.
//

import Foundation

class CommitManager: NSObject {
    
    static let shared = CommitManager()
    
    func getCommits() {
        
        // Create URL
        let url = URL(string: "https://api.github.com/repos/couchbase/couchbase-lite-android/commits?per_page=25")
        
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                print("The data count is: \(dataString.count)")
            }
            
        }
        task.resume()
        
    }
}
