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
   
    let fetchAllBreedsURL = "https://dog.ceo/api/breeds/list/all"
    let fetchRandomDogImageFromBreedURL = "https://dog.ceo/api/breed/%@/images/random"
    
    let parseErrorMsg = "Unable to parse data"
    
    //Fetch all dog breeds api call
    func fetchAllDogBreeds(completion:@escaping (Breed?, Error?)->())
    {
        Alamofire.request(fetchAllBreedsURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData(completionHandler: { (response) in
            
            switch response.result {
            case .success(let data) :
                do{
                        let dogBreeds = try JSONDecoder().decode(Breed.self, from: data)
                        completion(dogBreeds, nil)
                }catch{
                    completion(nil, self.createParseError())
                }
                    
                
                break
            case .failure(let error) :
                completion(nil,error)
                break
            }
            
        })
    }
    
    
    //Fetch random dog image from breed api call
    func fetchRandomDogImage(fromBreed breed:String, completion:@escaping (Dog?, Error?)->())
    {
        
        let urlString = fetchRandomDogImageFromBreedURL.replacingOccurrences(of: "%@", with: breed)
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData(completionHandler: { (response) in
            
            switch response.result {
            case .success(let data) :
                do{
                    
                    let dog = try JSONDecoder().decode(Dog.self, from: data)
                    let newDog = Dog(status: dog.status, breedName: breed, imageURL: dog.imageURL)
                        completion(newDog, nil)
                }
                    
                catch {
                    completion(nil, self.createParseError())
                }
                break
            case .failure(let error) :
                completion(nil,error)
                break
            }
            
        })
    }
    
    
 
}

extension NetworkManager{
    //Generate custom parse error
    private func createParseError() -> NSError{
        let error = NSError(domain: "com.shreya.mydog", code: -1, userInfo: [NSLocalizedDescriptionKey : self.parseErrorMsg])
        return error
    }
}


