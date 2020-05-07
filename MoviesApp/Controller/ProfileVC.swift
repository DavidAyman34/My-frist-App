//
//  ProfileVC.swift
//  MoviesApp
//
//  Created by Divo Ayman on 2/25/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit
import SQLite
import Kingfisher
class ProfileVC: UIViewController {
    var presentData = UserDefaultsManager.shared().getSavedData()
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var imageSQ : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        photo()
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        //self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 3
        self.profileImage.clipsToBounds = true
//        profileImage.layer.cornerRadius = profileImage.frame.height / 2
//        profileImage.clipsToBounds = true
        preview()
    SQLiteURl.openDataBase()
      
        // Do any additional setup after loading the view.
    }
    func photo(){
     let imageString =  SQLiteURl.returnDataSaved()
        let getProfileImage =  SQLiteURl.base64Convert(imageString: imageString)
        profileImage.image = getProfileImage
    }
   func preview(){
       nameLabel.text = UserDefaultsManager.shared().getSavedData().name
       emailLabel.text = UserDefaultsManager.shared().getSavedData().email
       phoneLabel.text = UserDefaultsManager.shared().getSavedData().phone
       genderLabel.text = UserDefaultsManager.shared().getSavedData().gender.map { $0.rawValue }
       addressLabel.text = UserDefaultsManager.shared().getSavedData().addres

   }
    @IBAction func clearBtn(_ sender: UIButton) {
        UserDefaultsManager.shared().clearUserSavedData()
        let SignupVC = UIStoryboard.init(name: Storybords.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signupVC) as! SignUpVC
        self.present(SignupVC, animated: true, completion: nil)
    }
    @IBAction func logOutBtn(_ sender: UIButton) {
        presentData.isLogin = false
        UserDefaultsManager.shared().saveDataFor(user: presentData)
        let SignInVC = UIStoryboard.init(name: Storybords.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signinVC) as! SignInVC
        self.present(SignInVC, animated: true, completion: nil)
    }
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        let moviesVC = UIStoryboard.init(name: Storybords.main, bundle: nil).instantiateViewController(withIdentifier:VCs.moviesVC) as! MoviesListVC
        self.present(moviesVC, animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
