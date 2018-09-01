//
//  Dog.swift
//  MyDog
//
//  Created by Shreya Dutta Chowdhury on 01/09/18.
//  Copyright © 2018 Shreya Dutta Chowdhury. All rights reserved.
//

import Foundation

struct Dog: Decodable {
    let status: String
    var breedName: String = ""
    
    let imageURL: String
    
    enum CodingKeys: String, CodingKey
    {
        case status = "status"
        case imageURL = "message"
    }
    
    init(status: String, breedName: String, imageURL: String) {
        self.status = status
        self.breedName = breedName
        self.imageURL = imageURL
    }

}


