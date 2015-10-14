//
//  DreamTableViewController.swift
//  Dream Diary
//
//  Created by Felis Perez on 9/30/15.
//
//

import UIKit

class DreamTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var dreams = [Dream]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        
        // Load any saved meals, otherwise load sample data.
        if let savedDreams = loadDreams() {
            dreams += savedDreams
        } else {
            // Load the sample data
            loadSampleDreams()
        }
    }
    
    func loadSampleDreams () {
        
//        let dream1 = Dream(dreamText: "My nightmare", dreamTitle: "A Bad Dream", nightmareBool: false)!
        let dream1 = Dream(dreamText: "My nightmare")!
        
        dreams += [dream1]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dreams.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DreamTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DreamTableViewCell
        
        // Fetches the appropriate dream for the data source layout
        
        let dream = dreams[indexPath.row]

        cell.titleLabel.text = dream.dreamText

        return cell
    }



    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            dreams.removeAtIndex(indexPath.row)
            saveDreams()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let dreamDetailViewController = segue.destinationViewController as! DreamViewController
    
            // Get the cell that generated this segue.
            if let selectedDreamCell = sender as? DreamTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedDreamCell)!
                let selectedDream = dreams[indexPath.row]
                dreamDetailViewController.dream = selectedDream
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new dream.")
        }
    }


    @IBAction func unwindToDreamList (sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.sourceViewController as?
            DreamViewController, dream = sourceViewController.dream {
                
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // Update an existing Dream.
                    dreams[selectedIndexPath.row] = dream
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                } else {
                    // Add a new dream.
                    let newIndexPath = NSIndexPath(forRow: dreams.count, inSection: 0)
                    dreams.append(dream)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                }
                
                saveDreams()
        }
    }
    
    // MARK: NSCoding
    
    func saveDreams() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dreams, toFile: Dream.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadDreams() -> [Dream]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Dream.ArchiveURL.path!) as? [Dream]
    }

}
