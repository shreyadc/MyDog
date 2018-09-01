//
//  DataProvider.swift
//  MyDog
//
//  Created by Shreya Dutta Chowdhury on 01/09/18.
//  Copyright © 2018 Shreya Dutta Chowdhury. All rights reserved.
//

import Foundation

class DataProvider {
    
    private var breed: Box<Breed?> = Box(nil)
    var dog: Box<Dog?> = Box(nil)
    
    init() {
        fetchAllDogBreeds()
    }
    
    private func fetchAllDogBreeds()
    {
        NetworkManager.shared.fetchAllDogBreeds { (breed, error) in
            if(error == nil)
            {
                self.breed.value = breed
            }
        }
    }
    

    
    func fetchRandomDog()
    {
        guard let breeds = breed.value?.breeds else { return }
        let randomIndex = Int(arc4random_uniform(UInt32(breeds.count)))
        let breedKeys = Array(breeds.keys)
        let randomKey = breedKeys[randomIndex]
        
        NetworkManager.shared.fetchRandomDogImage(fromBreed: randomKey) { (dog, err) in
            if err == nil{
                guard let dogObj = dog else{return}
                self.dog.value = dogObj
            }
        }
    }
    
}
