//
//  ViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 25.04.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var authorizationLabel: UILabel!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
    }
    
    func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @IBAction func loginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: self.loginField.text!, password: self.passwordField.text!){ (result, error) in
            if let error = error {
                print("ERROR! - \(error.localizedDescription)")
                let alert = UIAlertController(title: "Не правильный пароль", message: "Введите пароль еще раз", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                self.present(alert, animated: true)
            } else {
                self.performSegue(withIdentifier: "fromAutorizationToTubbarSegue", sender: nil)
            }
        }
    }
}

