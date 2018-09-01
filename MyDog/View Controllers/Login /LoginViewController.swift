//
//  LoginViewController.swift
//  MyDog
//
//  Created by Shreya Dutta Chowdhury on 01/09/18.
//  Copyright © 2018 Shreya Dutta Chowdhury. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI()
    {
        self.title = "Login"
        
        loginButton.layer.cornerRadius = 6.0
        validateLoginButton()
    }
    
    

    @IBAction func didTapLogin(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: isLoginDoneUserDefaultsKey)
        
        if(validateLogin())
        {
            displayHomePage()
        }else{
            let alert = UIAlertController(title: "Oops!", message: "Invalid Username or Password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}

extension LoginViewController
{
    
    func displayHomePage()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let rootController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: rootTabbarViewController)
        appDelegate.window?.rootViewController = rootController
    }
    
    func validateLogin() -> Bool
    {
        var isValidLogin = false
        if(usernameTextField.text == "username" && passwordTextField.text == "password")
        {
            isValidLogin = true
        }
        
        return isValidLogin
    }
    
    func validateLoginButton()
    {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {return}
        
        var isLoginEnabled = false
        if(username.count > 0 && password.count > 0)
        {
            isLoginEnabled = true
        }
        
        loginButton.isEnabled = isLoginEnabled
        loginButton.alpha = isLoginEnabled ? 1.0 : 0.5
    }
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let inputText = textField.text else{ return false }
        
        var shouldReturn = false
        
        if(textField == usernameTextField && inputText.count > 0)
        {
            passwordTextField.becomeFirstResponder()
            shouldReturn = true
        }
        else if(textField == passwordTextField && inputText.count > 0)
        {
            textField.resignFirstResponder()
            
            shouldReturn = true
        }
        
        return shouldReturn
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //block characters as required here
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.validateLoginButton()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateLoginButton()
    }
}
