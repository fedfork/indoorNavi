//  CoreDataHelper.swift
//  CDhse

import Foundation
import CoreData

public var context1 = NSManagedObjectContext(concurrencyType:
    NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)

class CoreDataHelper: NSObject {
    class var instance: CoreDataHelper {
        struct Singleton {
            static var instance = CoreDataHelper()
        }
        return Singleton.instance
    }
    
    let coordinator: NSPersistentStoreCoordinator
    // A coordinator that associates persistent stores with a model (or a configuration of a model) and that mediates between the persistent stores and the managed object contexts.
    let context: NSManagedObjectContext
    // An object representing a single object space or scratch pad that you use to fetch, create, and save managed objects.

    fileprivate override init() {
        let modelURL = Bundle.main.url(forResource: "TableModule", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        let fileManager = FileManager.default
        // An object that provides a convenient interface to the contents of the file system.

        
        let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        // Returns an array of URLs for the specified common directory in the requested domains.
        
        let storeURl = docURL!.appendingPathComponent("store.sqlite")
        
        var error: NSError?
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURl, options: [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true,])
        } catch let error1 as NSError {
            error = error1
            print("Cannot open database: \(String(describing: error))")
        }
        
        context = NSManagedObjectContext(concurrencyType:
        NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        
        context.persistentStoreCoordinator = coordinator
    }
    
}
