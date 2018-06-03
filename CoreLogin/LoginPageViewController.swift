//
//  LoginPageViewController.swift
//  CoreLogin
//
//  Created by Sukumar Anup Sukumaran on 02/06/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit
import  CoreData

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
     func fetchingProcesss()  {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if userTextField.text == data.value(forKey: Globally.shared.username) as? String && passTextField.text == data.value(forKey: Globally.shared.password) as? String{
                    print("Condition passed")
                    UserDefaults.standard.set(userTextField.text , forKey: Globally.shared.username)
                    UserDefaults.standard.set(true, forKey: Globally.shared.Session)
                    performSegue(withIdentifier: "unwindToProfilePage", sender: self)
                    
                } else {
                    print("Condition not  passed")
                    
                    
                }
                
            }
        } catch let error {
            print("CoreDataError = \(error.localizedDescription)")
        }
        
    }
    
    

    @IBAction func loginAction(_ sender: UIButton) {
        
        if (userTextField.text?.isEmpty)! || (passTextField.text?.isEmpty)! {
            
            print("Please login")
            
        }else{
            fetchingProcesss()
        }
    }
    
}
