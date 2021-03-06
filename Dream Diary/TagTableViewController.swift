//
//  TagTableViewController.swift
//  Dream Diary
//
//  Created by Harry Cooke on 10/25/15.
//
//

import UIKit

class TagTableViewController: UITableViewController {
    
    // Mark: Properties
    
    var tags = [Tag]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TagTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TagTableViewCell
        let tag = tags[indexPath.row]
        cell.selectionStyle = .None
        cell.tagLabel.text = tag.name
        
        //Set checkmarks
        if tag.selected {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
            
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        // Figure out if cell has been selected and set a checkmark if it is
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let touchedTag = tags[indexPath.row]
        
        if !touchedTag.selected {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            tags[indexPath.row].selected = true
        }
            
        else{
            cell!.accessoryType = UITableViewCellAccessoryType.None
            tags[indexPath.row].selected = false
        }
        cell!.selected = false
        
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        let touchedTag = tags[indexPath.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        // When cell deselected take away the checkmark
        if touchedTag.selected {
            cell!.accessoryType = UITableViewCellAccessoryType.None
            tags[indexPath.row].selected = false
            cell!.selected = false
        }
    }

    
    //@IBOutlet weak var doneButton: UIBarButtonItem!
    
    // Mark: Actions 
    
    
    // Set up alert view to pop up when you want to add a new tag
    @IBAction func newTagAlert(sender: AnyObject) {
        
        var inputTextField: UITextField?
        
        // Set the title and message of the alert
        let alertController = UIAlertController(title: "Add tag below", message: "Tags can be anything in your dream that will help you clasify or remember it.", preferredStyle: .Alert)
        
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            // Add a new tag to the tableview when you select okay
            let newIndexPath = NSIndexPath(forRow: self.tags.count, inSection: 0)
            if let tag = Tag(name: (inputTextField?.text)!) {
                self.tags.append(tag)
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                //self.saveTags()
            }
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            inputTextField = textField
        } 
        
        presentViewController(alertController, animated: true, completion: nil)
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
            tags.removeAtIndex(indexPath.row)
            //saveTags()
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

    
    // MARK: - Navigation
    
    // Go back to old view/
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let dreamVC = segue.destinationViewController as! DreamViewController
//        dreamVC.tags = tags
//        print("called")
//    }
    
    
    

}
