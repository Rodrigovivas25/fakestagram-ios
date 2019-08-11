//
//  CommentsTableClient.swift
//  fakestagram
//
//  Created by Rodrigo Vivas on 8/9/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class CommentsTableClient: RestClient<[Comment]> {
    convenience init() {
        self.init(client: Client(), path: "/api/posts")
    }
    
    func show(page: Int, success: @escaping codableResponse){
        request("GET", path: "/api/posts", payload: nil, success: success, errorHandler: nil)
        
    }
    
    func showComments(id: Int, success: @escaping codableResponse){
        request("GET", path: "/api/posts/\(id)/comments", payload: nil, success: success, errorHandler: nil)
    }
    
}
