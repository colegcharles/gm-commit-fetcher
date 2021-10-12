//
//  CommitManager.swift
//  gm-commit-fetcher
//
//  Created by Cole Charles on 10/12/21.
//

import Foundation

class CommitManager: NSObject {
    
    static let shared = CommitManager()
    var commits: [Commits] = []
    
    func getCommits(completion: @escaping ([Commits]) -> ()) {
        
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
            if let data = data {
                //print("Response data string:\n \(dataString)")
                
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Dictionary<String,Any>] {
                        for x in jsonArray
                        {
                            // initialize commit
                            var node = Commits()
                            // find the name value
                            let commit = x["commit"] as? [String: AnyObject]
                            let author = commit?["author"] as? [String: AnyObject]
                            let name = author?["name"] as! String
                            node.author = name
               
                            // find the hash
                            let hash = x["sha"] as! String
                            node.hash = hash
                            // find the message
                            let message = commit?["message"] as! String
                            node.message = message
                            self.commits.append(node)

                        }
                        completion(self.commits)
                    }
                    
                } catch {
                    print(error)
                }
                
            }
            
        }
        task.resume()
        
    }
}
