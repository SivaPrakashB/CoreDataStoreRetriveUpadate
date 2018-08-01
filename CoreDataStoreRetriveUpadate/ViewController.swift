//
//  ViewController.swift
//  CoreDataStoreRetriveUpadate
//
//  Created by Apple on 01/08/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var title123=[String]()
    var img123=[String]()
    
    @IBOutlet weak var label1: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //getTheDataFromServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func getTheDataFromServer()
    {//http://naradpost.news/WebService/GetNewsByLocations_with_ads.php?category=0&country=0&state=0&city=0&ward=0&skip=0&get=5&tm=13444
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        let url=URL(string:"http://naradpost.news/WebService/GetNewsByLocations_with_ads.php?category=0&country=0&state=0&city=0&ward=0&skip=0&get=4&tm=2000")
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) in
            if  error != nil
            {
                print(error)
            }
            else
            {
                do{
                    let resultJSON=try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as! NSDictionary
                    
                    let posts=resultJSON!["posts"] as! [NSDictionary]
                    
                    for value in posts{
                        let dicValue = value as! NSDictionary
                        //Refer to persistentContainer
                        var title=dicValue["title"] as! String
                        var img=dicValue["image"] as! String
                        DispatchQueue.main.async {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            //Create the context
                            let context = appDelegate.persistentContainer.viewContext
                            //Create an entity and new user records.
                            let entity = NSEntityDescription.entity(forEntityName: "NewsList", in: context)
                            let newUser = NSManagedObject(entity: entity!, insertInto: context)
                            newUser.setValue(title, forKey: "title")
                            newUser.setValue(img, forKey: "img")
                            //save data
                            do {
                                try context.save()
                                self.label1.text="DATA SAVED"
                            } catch {
                                print("Failed saving")
                            }
                        }
                        
                       
                        
                    }
                    //self.retriveCoreData()
                    
                    
                }
                catch{
                    print("\(error.localizedDescription)")
                }
                
            }
        })
        task.resume()
        
    }
    
    
    func retriveCoreData()
    {
        DispatchQueue.main.async {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "NewsList")
        fetchRequest.returnsObjectsAsFaults = false//This line will get list of array (If you won't wrote this line of code then You will get last value)
        //3
        do {
           let resulta = try managedContext.fetch(fetchRequest)
            
            
            for data in resulta as! [NSManagedObject] {
          
               var a = data.value(forKey: "title") as! String
               var a1 = data.value(forKey: "img") as! String
                self.title123.append(a)
                self.img123.append(a1)
                
            }
        } catch let error as NSError {
            print(error.localizedDescription,"--->Error occure")
        }
            self.label1.text="\(self.title123)"
        }
       
    }
    
    
    
    @IBAction func save(_ sender: UIButton) {
        getTheDataFromServer()
    }
    
    @IBAction func get(_ sender: UIButton) {
        var title123=[String]()
        var img123=[String]()
        retriveCoreData()
    }
    
    @IBAction func update(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            //1
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            //2
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "NewsList")
            fetchRequest.returnsObjectsAsFaults = false//This line will get list of array (If you won't wrote this line of code then You will get last value)
            
            //3
            do {
                let resulta = try managedContext.fetch(fetchRequest)
                
                
                for data in resulta as! [NSManagedObject] {
                    
                    managedContext.delete(data)
                    
                    self.label1.text="DATA DELETED"
                    
                    
                    
                    
                }
                var title123=[String]()
                var img123=[String]()
                self.getTheDataFromServer1()
            } catch let error as NSError {
                print(error.localizedDescription,"--->Error occure")
            }
            
            
            
        }

        
    }
    
    @IBAction func clear(_ sender: UIButton) {
      
        
        DispatchQueue.main.async {
            //1
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            //2
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "NewsList")
            fetchRequest.returnsObjectsAsFaults = false//This line will get list of array (If you won't wrote this line of code then You will get last value)
            
            //3
            do {
                let resulta = try managedContext.fetch(fetchRequest)
                
                
                for data in resulta as! [NSManagedObject] {
                    
                    managedContext.delete(data)
                   
                    self.label1.text="DATA DELETED"
                   
                    let st=UIStoryboard(name: "Main", bundle: nil)
                    let vc=st.instantiateViewController(withIdentifier: "first") as! UIViewController
                    self.present(vc, animated: false, completion: nil)
        
                  
                   
                }
                
            } catch let error as NSError {
                print(error.localizedDescription,"--->Error occure")
            }
            
           
            
        }
    }
    func getTheDataFromServer1()
    {//http://naradpost.news/WebService/GetNewsByLocations_with_ads.php?category=0&country=0&state=0&city=0&ward=0&skip=0&get=5&tm=13444
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        let url=URL(string:"http://naradpost.news/WebService/GetNewsByLocations_with_ads.php?category=0&country=0&state=0&city=0&ward=0&skip=4&get=5&tm=2000")
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) in
            if  error != nil
            {
                print(error)
            }
            else
            {
                do{
                    let resultJSON=try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as! NSDictionary
                    
                    let posts=resultJSON!["posts"] as! [NSDictionary]
                    
                    for value in posts{
                        let dicValue = value as! NSDictionary
                        //Refer to persistentContainer
                        var title=dicValue["title"] as! String
                        var img=dicValue["image"] as! String
                        DispatchQueue.main.async {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            //Create the context
                            let context = appDelegate.persistentContainer.viewContext
                            //Create an entity and new user records.
                            let entity = NSEntityDescription.entity(forEntityName: "NewsList", in: context)
                            let newUser = NSManagedObject(entity: entity!, insertInto: context)
                            newUser.setValue(title, forKey: "title")
                            newUser.setValue(img, forKey: "img")
                            //save data
                            do {
                                try context.save()
                                self.label1.text="DATA SAVED"
                            } catch {
                                print("Failed saving")
                            }
                        }
                        
                        
                        
                    }
                    //self.retriveCoreData()
                    
                    
                }
                catch{
                    print("\(error.localizedDescription)")
                }
                
            }
        })
        task.resume()
        
    }
}

