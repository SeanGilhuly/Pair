//
//  NameController.swift
//  Pair
//
//  Created by Sean Gilhuly on 7/8/16.
//  Copyright © 2016 Sean Gilhuly. All rights reserved.
//

import Foundation
import CoreData

class NameController {
    
    static let sharedController = NameController()
    
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        let request = NSFetchRequest(entityName: "Name")
        let groupSortDescriptor = NSSortDescriptor(key: "group", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)

        request.sortDescriptors = [groupSortDescriptor, nameSortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "group", cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Unable to perform fetch request")
        }
    }
    
    // MARK: - Functions
    
    func addName(name: String) {
        _ = Name(name: name)
        saveToPersistentStore()
    }
    
    func removeName(name: Name) {
        if let moc = name.managedObjectContext {
            moc.deleteObject(name)
            saveToPersistentStore()
        }
    }
    
    func saveToPersistentStore() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Failed to save to presistent storage \(#file) \(#function) \(#line)")
        }
    }

}