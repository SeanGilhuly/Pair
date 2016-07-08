//
//  PairRandomizerTableViewController.swift
//  Pair
//
//  Created by Sean Gilhuly on 7/8/16.
//  Copyright © 2016 Sean Gilhuly. All rights reserved.
//

import UIKit
import CoreData

class PairRandomizerTableViewController: UITableViewController {
    
    var names: Name?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: IBActions
    
    @IBAction func addNameButtonTapped(sender: AnyObject) {
        addNameAlert()
    }
    
    @IBAction func randomizeButtonTapped(sender: AnyObject) {
        
    }
    
    // MARK: Function
    
    func addNameAlert() {
        
        var nameTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Full Name"
            textField.autocapitalizationType = .Sentences
            nameTextField = textField
        }
        
        let createAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            guard let name = nameTextField?.text else { return }
            
            if name == "" {
                return
            } else {
                NameController.sharedController.addName(name)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        
        alertController.view.setNeedsLayout()

        presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sections = NameController.sharedController.fetchedResultsController.sections else {
            return 0
        }
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = NameController.sharedController.fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath)
        
        guard let name = NameController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Name else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = name.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        guard let sections = NameController.sharedController.fetchedResultsController.sections,
            index = Int(sections[section].name) else {
                return nil
        }
        
        if index == 2 {
            return "Group 1"
        } else {
            return "Group 2"
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension PairRandomizerTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case.Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath, newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}
