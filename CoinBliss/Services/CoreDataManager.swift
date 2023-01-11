//
//  CoreDataManager.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 11/01/2023.
//

import UIKit
import CoreData

class CoreDataManager {
    
    func save(payment: Payment) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Payment", in: managedContext)!
        
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        
        object.setValue(payment.id, forKeyPath: "id")
        object.setValue(payment.amount, forKeyPath: "amount")
        object.setValue(payment.currency, forKeyPath: "currency")
        object.setValue(payment.categoryId, forKeyPath: "categoryId")
        object.setValue(payment.period, forKeyPath: "period")
        object.setValue(payment.date, forKeyPath: "date")
        object.setValue(payment.note, forKeyPath: "note")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func save(category: Category) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)!
        
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        
        object.setValue(category.id, forKeyPath: "id")
        object.setValue(category.name, forKeyPath: "name")
        object.setValue(category.imageName, forKeyPath: "imageName")
        object.setValue(category.hexColor, forKeyPath: "hexColor")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchPayments() -> [Payment] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Payment")
        
        var fetchObjects: [NSManagedObject] = []
        
        do {
            fetchObjects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        let payments: [Payment] = fetchObjects.map { object in
            Payment(id: object.value(forKey: "id") as? Int ?? 0,
                    amount: object.value(forKey: "amount") as? Double ?? 0,
                    currency: object.value(forKey: "currency") as? String ?? "",
                    categoryId: object.value(forKey: "categoryId") as? Int ?? 0,
                    period: object.value(forKey: "period") as? String ?? "",
                    date: object.value(forKey: "date") as? Date ?? Date())
        }
        
        return payments
    }
    
    func fetchCategories() -> [Int: Category] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [:] }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
        
        var fetchObjects: [NSManagedObject] = []
        
        do {
            fetchObjects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        let categories: [Category] = fetchObjects.map { object in
                Category(id: object.value(forKey: "id") as? Int ?? 0,
                         name: object.value(forKey: "name") as? String ?? "",
                         imageName: object.value(forKey: "imageName") as? String ?? "",
                         hexColor: object.value(forKey: "hexColor") as? String ?? "")
            
        }
        
        return Dictionary(uniqueKeysWithValues: categories.map {($0.id, $0)})
    }
}
