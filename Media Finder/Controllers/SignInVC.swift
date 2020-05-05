//
//  SignInVC.swift
//  Media Finder
//
//  Created by Ahmed Kamal on 2/26/20.
//  Copyright © 2020 Intake 4. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var loggedinLabel: UILabel!
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var pwLoginTextField: UITextField!
    let database = DatabaseManager.shared()
    let userDefault = UserDefaultsManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.endEditing(true)
        self.navigationController?.isNavigationBarHidden = true
        database.listUsersTable()
        database.listCachDataTable()
        database.DbConnection()
    }
    
    func checkingData() -> Bool {
        if database.userExists(email: emailLoginTextField.text!, password: pwLoginTextField.text!) {
            return true
        }
        return false
    }
    
    private func isValidData() -> Bool {
        if let email = emailLoginTextField.text, !email.isEmpty, let password = pwLoginTextField.text, !password.isEmpty { if email.isValidEmail, password.isValidPassword {
            return true
            }
        }
        return false
    }
    
    @IBAction func LoginBtnPressed(_ sender: UIButton) {
        if isValidData() && checkingData() {
            let tabBar = MainTabBarController()
            self.navigationController?.pushViewController(tabBar, animated: true)
            userDefault.isLoggedIn = true
        } else {
            loggedinLabel.font = loggedinLabel.font.withSize(20)
            loggedinLabel.text = "Ur Email or Password is Wrong"

        }
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        let signUpBack = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signUpBack, animated: true)
    }
}
