//
//  DreamTableViewController.swift
//  Dream Diary
//
//  Created by Felis Perez on 9/30/15.
//
//

import UIKit

class DreamTableViewController: UITableViewController, UISearchResultsUpdating{
    
        
    // MARK: Properties
    
    var dreams = [Dream]()
    var filteredDreams = [Dream]()
    var resultSearchController: UISearchController!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        
        self.tableView.reloadData()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        
        // Load any saved dreams, otherwise load sample data.
        if let savedDreams = loadDreams() {
            dreams += savedDreams
        } else {
            // Load the sample data
            loadSampleDreams()
        }
    }
    
    func loadSampleDreams () {
        
        let dream1 = Dream(dreamText: "My nightmare", dreamTitle: "A Bad Dream", isNightmare: true, isRepeat: false, date: NSDate())!
        
        dreams += [dream1]
        
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
        if (self.resultSearchController.active){
            return self.filteredDreams.count
        }
        else{
            return self.dreams.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DreamTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DreamTableViewCell
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M/d"    // format dates as month/day
        
        // Filter dreams if you are searching
        if (self.resultSearchController.active){
            //cell.dreamTextLabel?.text = self.filteredDreams[indexPath.row].dreamText
            cell.dreamTitleLabel?.text = self.filteredDreams[indexPath.row].dreamTitle
            cell.dreamDateLabel?.text = dateFormatter.stringFromDate(self.filteredDreams[indexPath.row].date)
        }
        
        // Otherwise just show all the dreams
        else{
            //cell.dreamTextLabel?.text = self.dreams[indexPath.row].dreamText
            cell.dreamTitleLabel?.text = self.dreams[indexPath.row].dreamTitle
            cell.dreamDateLabel?.text = dateFormatter.stringFromDate(self.dreams[indexPath.row].date)
        }
        
        // Fetches the appropriate dream for the data source layout
        return cell

    }



    // Supports conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        self.filteredDreams.removeAll(keepCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        
        var textArray: [String] = []
        
        // Go through and get strings and put the text of each one in an array
        for var i = 0; i < dreams.count; ++i{
            textArray.append(dreams[i].dreamText)
        }
        
        // Filter the array of strings to get dreams with the text you are looking for
        let array = (textArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        var dreamArray: [Dream] = []
        
        // Put the text back into as dreams
        for var i = 0; i < array.count; ++i{
            let filtDream = Dream(dreamText: array[i] as! String)
            dreamArray.append(filtDream!)
        }
        
        self.filteredDreams = dreamArray
        
        // Reload the tableView with the filtered dreams
        self.tableView.reloadData()
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
    
    // MARK: Actions
    @IBAction func unwindToDreamListWithoutSaving(sender: UIStoryboardSegue)
    {
        //let sourceViewController = sender.sourceViewController
        // Pull any data from the view controller which initiated the unwind segue.
        //print(dreams[1].dreamText)
        //saveDreams()
    }
    
    // MARK: NSCoding
    
    func saveDreams() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dreams, toFile: Dream.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save dreams...")
        }
    }
    
    func loadDreams() -> [Dream]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Dream.ArchiveURL.path!) as? [Dream]
    }

}
