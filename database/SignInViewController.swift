//
//  SigninViewController.swift
//  database
//
//  Created by Максим Варакин on 25.03.2020.
//  Copyright © 2020 kekDevs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SigninViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        

        // Do any additional setup after loading the view.
    }
    
    func chekValid() -> String? {
        if firstNameTextField.text == "" ||
         lastNameTextField.text == "" ||
         emailTextField.text == "" ||
         passwordTextField.text == "" ||
         firstNameTextField.text == nil ||
         firstNameTextField.text == nil ||
         lastNameTextField.text == nil ||
         emailTextField.text == nil ||
         passwordTextField.text == nil {
            print("bullshit")
            return "please fill in all fiells"
        }
        return nil
    }

   
    @IBAction func signInPressed(_ sender: Any) {
        let error = chekValid()
        
        if error != nil {
            errorLabel.alpha = 1
            errorLabel.text = error
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                if error != nil {
                    self.errorLabel.text = "\(String(describing: error?.localizedDescription))"
                } else {
                    // регистрация нового пользователя
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "firstname": self.firstNameTextField.text!,
                        "lastname": self.lastNameTextField.text!,
                        "uid": result!.user.uid
                    ]) { (error) in
                        if error != nil {
                            self.errorLabel.text = "error saving user in database"
                        }
                    }
                    
                    print("Sign In complete!")
                }
            }
        }
    }
    
}
