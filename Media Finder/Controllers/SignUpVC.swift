import UIKit

class SignUpVC: UIViewController {
 
    @IBOutlet weak var addPicImageView: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    
    var address: String!
    let database = DatabaseManager.shared()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func isValidData() -> Bool {
        if let name = fullNameTextField.text, !name.isEmpty, let email = emailTextField.text, !email.isEmpty, let address = locationLabel.text, !address.isEmpty, let password = passwordTextField.text, !password.isEmpty, let contact = contactNumberTextField.text, !contact.isEmpty, let image = addPicImageView.image, image != UIImage(named: "CreateAcc") {
            if email.isValidEmail, password.isValidPassword, contact.isPhoneNumber, database.emailNotExists(email: email) {
                return true
            } else {
                let alert = UIAlertController(title: "Fields Required!", message: "", preferredStyle: UIAlertController.Style.alert)
                
                if email.isValidEmail == false {
                    alert.message = "Your Email Address is wrong, please try again"
                }
                if password.isValidPassword == false {
                    alert.message = "Your password is wrong, please try again, your password at least 8 character & at least one letter "
                }
                if contact.isPhoneNumber == false {
                    alert.message = "Your phone no. is wrong, please try again, your phone no. should be 11 numbers"
                }
                
                if database.emailNotExists(email: email) == false {
                    alert.title = "Email Address already Exists"
                    alert.message = "Your Email Address already Exists, please try another email address"
                }
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        return false
    }
    
    
    
    
    
    func gotToSignIn() {
        let signInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        navigationController?.pushViewController(signInVC, animated: true)
        
    }
    
    func checkUser() {
        database.createUsersTable()
        database.createCachDataTable()
        let user = User(name: fullNameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", contactNum: contactNumberTextField.text ?? "", img: addPicImageView.image?.pngData(), address: address)
       database.insertUsers(user: user)
       database.insertCacheData()
    }
    
    @IBAction func pickLocation(_ sender: UIButton) {
        let pickLocation = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as! MapVC
        pickLocation.delegate = self
        navigationController?.pushViewController(pickLocation, animated: true)
        
    }
    @IBAction func joinBtnPressed(_ sender: UIButton) {
        if isValidData() {
            checkUser()
            gotToSignIn()
        } else {
            let alert = UIAlertController(title: "Fields Required!", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.message = "Please fill all text fields"
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
   
}

extension SignUpVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBAction func addPicButtonpressed(_ sender: UIButton) {
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage {
            addPicImageView.image = chosenImage
            
        }
        dismiss(animated: true, completion: nil)
    }
}

extension SignUpVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension SignUpVC: SendingMessageDelegate {
    func messageData(data: String) {
            locationLabel.text = "Your location is \(data)"
            self.address = data
    }
}
