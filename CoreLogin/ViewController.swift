//
//  ViewController.swift
//  CoreLogin
//
//  Created by Sukumar Anup Sukumaran on 02/06/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var users:[Users] = []
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRequest()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
         loginChecker()
    }
    
    func fetchRequest() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
           
            if result.isEmpty {
                
                let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
               
                newUser.setValue("Anish", forKey: "username")
                newUser.setValue("54128", forKey: "password")
                newUser.setValue("Anup", forKey: "username")
                newUser.setValue("12345", forKey: "password")
                
                
                do{
                    try context.save()
                }catch let error {
                    print("CDE1 = \(error.localizedDescription)")
                }
                
                print("is Empty")
            }else{
                print("Not Empty")
                
            }
           
            
            
        } catch let error {
            print("CoreData \(error.localizedDescription)")
        }
      
        
    }
    
    func loginChecker(){
        
        
        
        if UserDefaults.standard.bool(forKey: Globally.shared.Session) {
            userNameLabel.text = UserDefaults.standard.value(forKey: Globally.shared.username) as? String
            print("INSESSION")
            print("Already loged in = \(UserDefaults.standard.bool(forKey: Globally.shared.Session))")
            
        }else{
            print("NOTINSESSION")
            print("Already loged in = \(UserDefaults.standard.bool(forKey: Globally.shared.Session))")
            callingLoginPage()
        }
        
        
        
    }
    
    func callingLoginPage() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page1") as! LoginPageViewController
        
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func LogOutAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: Globally.shared.Session)
        UserDefaults.standard.removeObject(forKey: Globally.shared.username)
        callingLoginPage()
    }
    
    
    
    @IBAction func unwindToProfilePage(segue: UIStoryboardSegue){
        print("UnwindingWorks")
    }
    
    

   
}

