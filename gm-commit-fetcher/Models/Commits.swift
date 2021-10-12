//
//  Commits.swift
//  gm-commit-fetcher
//
//  Created by Cole Charles on 10/12/21.
//

import Foundation

struct Commits: Codable{
    var author: String
    var message: String
    var hash: String
    
    init(){
        self.author = ""
        self.message = ""
        self.hash = ""
    }
}
