//
//  Name+CoreDataProperties.swift
//  Pair
//
//  Created by Sean Gilhuly on 7/8/16.
//  Copyright © 2016 Sean Gilhuly. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Name {

    @NSManaged var name: String?
    @NSManaged var group: NSNumber?

}
