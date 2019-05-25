//
//  LikeClient.swift
//  fakestagram
//
//  Created by Rodrigo Vivas Maldonado D3 on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class LikeUpdaterClient {
    private let client = Client()
    private let basepath = "/api/posts"
    private let post: Post
    private let row: Int
    
    init(post: Post, row: Int){
        self.post = post
        self.row = row
    }
    
    func call() -> Post{
        if !post.liked{
            return like()
        }else{
            return dislike()
        }
    }
    
    func like() -> Post {
        guard let postId = self.post.id else {return self.post}
        client.request("POST", path: "\(basepath)/\(postId)/like", body: nil, completionHandler: onSuccessLike(response:data:), errorHandler: onError(error:))
        var post = self.post
        post.likesCount += 1
        post.liked = true
        return post
        
    }
    
    func dislike() -> Post{
        guard let postId = self.post.id else {return self.post}
        client.request("DELETE", path: "\(basepath)/\(postId)/like", body: nil, completionHandler: onSuccessDislike(response:data:), errorHandler: onError(error:))
        var post = self.post
        post.likesCount -= 1
        post.liked = false
        return post
    }
    
    func onSuccessLike(response: HTTPResponse, data: Data?){
        guard response.successful() else {return}
        var post = self.post
        post.likesCount += 1
        post.liked = true
        sendNotification(for: post)
        
    }
    
    func onSuccessDislike(response: HTTPResponse, data: Data?){
        guard response.successful() else {return}
        var post = self.post
        post.likesCount -= 1
        post.liked = false
        sendNotification(for: post)
    }
    
    private func onError(error: Error?) -> Void {
        guard let err = error else {return}
        print("Error on post request: \(err.localizedDescription)")
    }
    
    private func sendNotification(for updatedPost: Post){
        guard let data = try? JSONEncoder().encode(updatedPost) else {return}
        NotificationCenter.default.post(name: .didLikePost, object: nil, userInfo: ["post" : data as Any, "row": row as Any])
    }
}
