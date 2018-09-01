//
//  MyDogViewController.swift
//  MyDog
//
//  Created by Shreya Dutta Chowdhury on 01/09/18.
//  Copyright © 2018 Shreya Dutta Chowdhury. All rights reserved.
//

import UIKit
import AlamofireImage

class MyDogViewController: UIViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var changeDogBtn: UIButton!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    
    private let dataProvider = DataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribeListeners()
        dataProvider.fetchRandomDog()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setupUI(){
        loadingView.layer.cornerRadius = 3.0
        loadingView.startAnimating()
        changeDogBtn.layer.cornerRadius = 6.0
    }
    
    private func subscribeListeners()
    {
        dataProvider.dog.bind { [unowned self] (dog) in
            if let imageURL = URL(string:dog?.imageURL ?? ""){
               // self.dogImageView.af_setImage(withURL: imageURL, placeholderImage: UIImage(named: "placeholder"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: false, completion: nil)
                
                self.dogImageView.af_setImage(withURL: imageURL, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: false, completion: { (_) in
                        self.loadingView.stopAnimating()
                })
            }
            self.dogNameLabel.text = dog?.breedName.uppercased()
        }
    }

    

    @IBAction func changeDogBtnTapped(_ sender: UIButton) {
        loadingView.startAnimating()
        clearDogInfo()
        dataProvider.fetchRandomDog()
    }
    

    private func clearDogInfo()
    {
        dogImageView.image = nil
        dogNameLabel.text = " "
    }
}
