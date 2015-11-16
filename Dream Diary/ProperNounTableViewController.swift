//
//  ProperNounTableViewController.swift
//  Dream Diary
//
//  Created by Andrew Scott on 11/11/15.
//
//

import UIKit

class ProperNounTableViewController: UITableViewController {

    var properNouns = [Tag]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return properNouns.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ProperNounTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProperNounTableViewCell
        let noun = properNouns[indexPath.row]
        cell.selectionStyle = .None
        cell.nounLabel.text = noun.name
        
        //Set checkmarks
        if noun.selected {
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
        let touchedTag = properNouns[indexPath.row]
        
        if !touchedTag.selected {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            properNouns[indexPath.row].selected = true
        }
            
        else{
            cell!.accessoryType = UITableViewCellAccessoryType.None
            properNouns[indexPath.row].selected = false
        }
        cell!.selected = false
        
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        let touchedTag = properNouns[indexPath.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        // When cell deselected take away the checkmark
        if touchedTag.selected {
            cell!.accessoryType = UITableViewCellAccessoryType.None
            properNouns[indexPath.row].selected = false
            cell!.selected = false
        }
    }
    
    // Set up alert view to pop up when you want to add a new proper noun
    @IBAction func newTagAlert(sender: AnyObject) {
        
        var inputTextField: UITextField?
        
        // Set the title and message of the alert
        let alertController = UIAlertController(title: "Add noun below", message: "Any proper nouns from your dream that will help you remember the dream.", preferredStyle: .Alert)
        
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            // Add a new tag to the tableview when you select okay
            let newIndexPath = NSIndexPath(forRow: self.properNouns.count, inSection: 0)
            if let tag = Tag(name: (inputTextField?.text)!) {
                self.properNouns.append(tag)
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            inputTextField = textField
            inputTextField?.autocapitalizationType = UITextAutocapitalizationType.Sentences
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
            properNouns.removeAtIndex(indexPath.row)
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
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
