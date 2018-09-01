//
//  Dog.swift
//  MyDog
//
//  Created by Shreya Dutta Chowdhury on 01/09/18.
//  Copyright © 2018 Shreya Dutta Chowdhury. All rights reserved.
//

import Foundation

struct Breed: Decodable {
    let status: String
    let breeds: [String: [String]]
    
    enum CodingKeys: String, CodingKey
    {
        case status = "status"
        case breeds = "message"
    }
}
