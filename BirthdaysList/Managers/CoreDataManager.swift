import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    static let instance = CoreDataManager()
    
    func savePerson(_ user: Person) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PersonEntity", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(user.name, forKey: "name")
        person.setValue(user.surname, forKey: "surname")
        person.setValue(user.date, forKey: "date")
        
        do {
           try managedContext.save()
            print("Saved")
        } catch let error as NSError {
            print("Error - \(error)")
        }
    }
    
    func getperson() -> [Person]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonEntity")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            var users = [Person]()
            for object in objects {
                guard let name = object.value(forKey: "name") as? String, let surname = object.value(forKey: "surname") as? String, let date = object.value(forKey: "date") as? Date else {
                    return nil
                }
                let user = Person(name: name, surname: surname, date: date)
                users.append(user)
            }
            return users
        } catch let error as NSError {
            print("Error - \(error)")
        }
        
        return nil
    }
    
    func deletePerson() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonEntity")
        
        if let objects = try? managedContext.fetch(fetchRequest) {
            for object in objects {
                managedContext.delete(object)
        }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    private init() {}
}
