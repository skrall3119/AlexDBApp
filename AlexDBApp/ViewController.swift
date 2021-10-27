//
//  ViewController.swift
//  AlexDBApp
//
//  Created by Alex Janci on 10/27/21.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    
    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()

    @IBAction func saveRecord(_ sender: Any) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
        newEntity.setValue(imgDescription.text!, forKey: "about")
        
        do {
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch {
            print("Error Saving Data")
        }
        resultLabel.text?.removeAll()
        imgDescription.text?.removeAll()
        fetchData()
    }
    
    @IBAction func deleteRecord(_ sender: Any) {
        let deleteItem = imgDescription.text!
        for item in listArray {
            if item.value(forKey: "about") as! String == deleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            } catch {
                print("Error deleting data")
            }
            resultLabel.text?.removeAll()
            imgDescription.text?.removeAll()
            fetchData()
        }
    }
    
    @IBOutlet weak var imgDescription: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        resultLabel.text?.removeAll()
        fetchData()
    }
    
    func fetchData(){
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                let product = item.value(forKey: "about") as! String
                resultLabel.text! += product
            }
        } catch {
            print("error retrieving data")
        }
    }


}

