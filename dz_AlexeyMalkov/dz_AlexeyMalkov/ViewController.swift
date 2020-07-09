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
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name(rawValue: "loginNotification"), object: nil)
        
//        Auth.auth().signIn(withEmail: "test@test.com", password: "123456"){ (result, error) in
//            if let error = error {
//                print("ERROR! - \(error.localizedDescription)")
//            } else {
//                print(result?.user.email)
//            }
//        }
        
//        Auth.auth().createUser(withEmail: "test2@test.com", password: "654321") { (result, error) in
//            if let error = error {
//                            print("ERROR! - \(error.localizedDescription)")
//                        } else {
//                            print(result?.user.email)
//                        }
//
//        }
        
    }
    
    @objc func loginSuccess(){
        print("Пользователь успешно авторизировался")
    }

    @IBAction func loginButton(_ sender: UIButton) {
//        let login = loginField.text!
//        let password = passwordField.text!
//        if login == "admin" && password == "123456"{
//            performSegue(withIdentifier: "fromAutorizationToTubbarSegue", sender: self)
//        } else {
//            let alert = UIAlertController(title: "Не правильный пароль", message: "Введите пароль еще раз", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
//
//            self.present(alert, animated: true)
//            print("Неуспешная авторизация")
//        }
        
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

