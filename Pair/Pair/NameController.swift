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
        request.sortDescriptors = [groupSortDescriptor]
        
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
    
    func saveToPersistentStore() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Failed to save to presistent storage \(#file) \(#function) \(#line)")
        }
    }

}