//
//  NetworkManager.swift
//  MyDog
//
//  Created by Shreya Dutta Chowdhury on 01/09/18.
//  Copyright © 2018 Shreya Dutta Chowdhury. All rights reserved.
//

import Foundation
import Alamofire


class NetworkManager {
    
    static let shared = NetworkManager()
   
    
    
    func fetchAllDogBreeds(completion:@escaping (Breed?, Error?)->())
    {
        let fetchAllBreedsURL = "https://dog.ceo/api/breeds/list/all"
        Alamofire.request(fetchAllBreedsURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData(completionHandler: { (response) in
            
            switch response.result {
            case .success(let data) :
                do{
                    //
                    if let statusCode = response.response?.statusCode{
                        
                        //                    let responseJson = try JSONSerialization.jsonObject(with: data, options: [])
                        //                    print(responseJson)
                        
                        
                        let dogBreeds = try? JSONDecoder().decode(Breed.self, from: data)
                        print(dogBreeds)
                        completion(dogBreeds, nil)
                        
                    }
                }
                    
                catch {
                    let userDict:Dictionary<String,Any> = Dictionary()
                    //completionHandler(userDict, nil)
                    
                }
                break
            case .failure(let error) :
                print(error)
                let userInfo = Dictionary<String,Any>()
                //completionHandler(userInfo,error)
                break
            }
            
        })
    }
    
    func fetchRandomDogImage(fromBreed breed:String, completion:@escaping (Dog?, Error?)->())
    {
        
        let url = "https://dog.ceo/api/breed/\(breed)/images/random"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData(completionHandler: { (response) in
            
            switch response.result {
            case .success(let data) :
                do{
                    //
                    if let statusCode = response.response?.statusCode{
                        
                        //                    let responseJson = try JSONSerialization.jsonObject(with: data, options: [])
                        //                    print(responseJson)
                        
                        
                        let dog = try? JSONDecoder().decode(Dog.self, from: data)
                        guard let dogStatus = dog?.status, let dogImage = dog?.imageURL else {return}
                        //print(dogBreeds)
//                        let newDog = Dog(status: "", imageURL: <#T##String#>)
//                        let newDog = Dog(status: dog!.status, imageURL: dog!.imageURL)
                        let newDog = Dog(status: dogStatus, breedName: breed, imageURL: dogImage)
                        completion(newDog, nil)
                        
                    }
                }
                    
                catch {
                    let userDict:Dictionary<String,Any> = Dictionary()
                    //completionHandler(userDict, nil)
                    
                }
                break
            case .failure(let error) :
                print(error)
                let userInfo = Dictionary<String,Any>()
                //completionHandler(userInfo,error)
                break
            }
            
        })
    }
    
}


