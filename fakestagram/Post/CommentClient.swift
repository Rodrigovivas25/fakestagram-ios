//
//  CommentClient.swift
//  fakestagram
//
//  Created by Rodrigo Vivas on 7/30/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct CreateComment: Codable {
    let content: String
}

class CommentClient{
    private let client = Client()
    private let basepath = "/api/posts"
    private let post: Post
    
    //private let row: Int
    let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    let decoder : JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(post: Post){
        self.post = post
        //self.row = row
    }
    
    
    
    func create(content: CreateComment, success: @escaping (Comment) -> Void){
        guard let postId = post.id else {return}
        guard let data = try? encoder.encode(content) else {return}
        
        client.request("POST", path: "\(basepath)/\(postId)/comments", body: data, completionHandler: { (response, data) in
            if response.successful(){
                guard let data = data else{
                    print("Empty data")
                    return
                }
                do{
                    let json = try self.decoder.decode(Comment.self, from: data)
                    success(json)
                }catch let err{
                    print("Error on serialization: \(err.localizedDescription)")
                }
            }else{
                print("Error on response: \(response.rawResponse) - \(response.status): \nBody: \(String(describing: data))")
            }
        }, errorHandler: self.onError(error:))
    }
    
    private func onError(error: Error?){
        guard let err = error else { return }
        print("Error on post request: \(err.localizedDescription)")
    }
    
}
