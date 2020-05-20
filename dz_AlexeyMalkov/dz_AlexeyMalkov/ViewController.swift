//
//  ViewController.swift
//  dz_AlexeyMalkov
//
//  Created by Алексей Мальков on 25.04.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var authorizationLabel: UILabel!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButton(_ sender: UIButton) {
        let login = loginField.text!
        let password = passwordField.text!
        if login == "admin" && password == "123456"{
            print("Успешная авторизация")
            performSegue(withIdentifier: "fromAutorizationToTubbarSegue", sender: self)
        } else {
            let alert = UIAlertController(title: "Не правильный пароль", message: "Введите пароль еще раз", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))

            self.present(alert, animated: true)
            print("Неуспешная авторизация")
        }
        
    }
    
}

