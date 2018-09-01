//
//  Box.swift
//  MyDog
//
//  Created by Shreya Dutta Chowdhury on 01/09/18.
//  Copyright © 2018 Shreya Dutta Chowdhury. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value: T)
    {
        self.value = value
    }
    
    func bind(_ listener: Listener?)
    {
        self.listener = listener
        listener?(value)
    }
    
}
