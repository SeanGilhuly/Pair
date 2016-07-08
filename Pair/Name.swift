//
//  Name.swift
//  Pair
//
//  Created by Sean Gilhuly on 7/8/16.
//  Copyright © 2016 Sean Gilhuly. All rights reserved.
//

import Foundation
import CoreData


class Name: NSManagedObject {

    convenience init?(name: String, group: Bool = false, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entityForName("Name", inManagedObjectContext: context) else { return nil }
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.group = group
    }
}
