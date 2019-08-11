//
//  Comment.swift
//  fakestagram
//
//  Created by Rodrigo Vivas on 7/30/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Comment: Codable{
    let author: Author?
    let content: String
    let createdAt: String
    let updatedAt: String
}
