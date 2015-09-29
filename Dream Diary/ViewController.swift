//
//  ViewController.swift
//  Dream Diary
//
//  Created by Andrew Scott on 9/17/15.
//
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textBox: UITextView!
    @IBOutlet weak var dreamNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textBox.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewShouldReturn(textView: UITextView) -> Bool {
        
        textView.resignFirstResponder()
        
        return true
    }
    
//    func textViewDidEndEditing(textView: UITextView) {
//        
//        dreamNameLabel.text = "Save your dream below"
//    }


//    @IBAction func saveButton(sender: UIButton) {
//    }
}



