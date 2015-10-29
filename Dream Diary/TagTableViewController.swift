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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // put in edit button
        //navigationItem.leftBarButtonItem = editButtonItem()
        // load dummy tags so it looks good
        
        loadSampleTags()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    
    var lastSelectedIndexPath = NSIndexPath(forRow: -1, inSection: 0)

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TagTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TagTableViewCell
        
        let tag = tags[indexPath.row]
        
        cell.tagLabel.text = tag
        
        if cell.selected {
            print("1")

            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            //selectedTags.append(cell.tagLabel.text!)
        }
            
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
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
        
        if cell!.selected == false{
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
        //tableView.indexPathsForSelectedRows
       
    }

    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func newTagAlert(sender: AnyObject) {

        var inputTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add tag below", message: "Tags can be anything in your dream that will help you clasify or remember it.", preferredStyle: .Alert)
        
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            // Add a new tag to the tableview
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
        
       // let defaultAction = UIAlertAction(title: "Add", style: .Default, handler: nil)
        
       // alertController.addAction(defaultAction)
        /*
        //Create the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //TODO
        }
        alertController.addAction(cancelAction)
        
        //Create add
        let nextAction: UIAlertAction = UIAlertAction(title: "Next", style: .Default) { action -> Void in
            //TODO
        }
        alertController.addAction(nextAction)
        
        alertController.addTextFieldWithConfigurationHandler { textField -> Void in
            //TextField configuration
            textField.textColor = UIColor.blueColor()
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
*/
        /*
let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
// Do whatever you want with inputTextField?.text

        ln("\(inputTextField?.text)")
})
let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in }

alertController.addAction(ok)
alertController.addAction(cancel)

alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
inputTextField = textField
}

presentViewController(alertController, animated: true, completion: nil)
*/

    }
    
    // TODO talk about UI and how to add edit, new tag and go back
    /*
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

*/

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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            if let indexPaths = tableView.indexPathsForSelectedRows {
                for var i = 0; i < indexPaths.count; ++i {
                    
                    let thisPath = indexPaths[i] as NSIndexPath
                    let cell = tableView.cellForRowAtIndexPath(thisPath) as! TagTableViewCell
                    print(cell.tagLabel.text)
                }
            }

        }
    }
    

}
