

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileVCImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    let database = DatabaseManager.shared()
    let userDefault = UserDefaultsManager.shared()

    override func viewDidLoad() {
    super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden =  true
    
        getUser()
    }
    
    func getUser() {
        let user = database.getUserData()
        if let imageData = user?.img {
            profileVCImageView.image = UIImage(data: imageData)
        }
        nameLabel.text  = user?.name
        emailLabel.text = user?.email
        contactNumberLabel.text = user?.contactNum
    }



    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        let logOut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(logOut, animated: true)
       userDefault.isLoggedIn = false
        hideTabBar()
    }
    
    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }


}
