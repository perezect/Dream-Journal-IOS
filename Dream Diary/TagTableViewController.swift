//
//  TagTableViewController.swift
//  Dream Diary
//
//  Created by Harry Cooke on 10/25/15.
//
//

import UIKit

class TagTableViewController: UITableViewController {
    
    //Mark Properties 
    
    var tags = [String]()
    var selectedTags = [String]()
    var lastSelectedIndexPath = NSIndexPath(forRow: -1, inSection: 0)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load dummy tags so it looks good
        
        loadSampleTags()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    func loadSampleTags() {
        let tag1 = "test tag"
        tags += [tag1]
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
        // #warning Incomplete implementation, return the number of rows
        return tags.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TagTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TagTableViewCell

        let tag = tags[indexPath.row]
        
        cell.tagLabel.text = tag
        
        //Set checkmarks
        if cell.selected {
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
        
        if cell!.selected == true{
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
            
        else{
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
        
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        // When cell deselected take away the checkmark
        if cell!.selected == false{
            cell!.accessoryType = UITableViewCellAccessoryType.None
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
            self.tags.append((inputTextField?.text)!)
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            inputTextField = textField
        } 
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // TODO talk about UI and how to add edit, new tag and go back
    
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
            //saveDreams()
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
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            if let indexPaths = tableView.indexPathsForSelectedRows {
                for var i = 0; i < indexPaths.count; ++i {
                    
                    let thisPath = indexPaths[i] as NSIndexPath
                    let cell = tableView.cellForRowAtIndexPath(thisPath) as! TagTableViewCell
                    print(cell.tagLabel.text)
                }
            }

        }
    }*/
    

}
