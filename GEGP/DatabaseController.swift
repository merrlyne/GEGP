//
//  DatabaseController.swift
//  GEGP
//
//  Created by Eric Fry on 4/25/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController{
    
    private init(){
        
    }
    
    
    // MARK: - Core Data Stack
    
    class func getContext () -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TAMUCDataModel")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    class func saveContext () {
        let context = DatabaseController.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
