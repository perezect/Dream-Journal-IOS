//
//  DrawingViewController.swift
//  Dream Diary
//
//  Created by Felis Perez on 11/18/15.
//
//


import UIKit

class DrawingViewController: UIViewController {
    
    var mostRecent:CGPoint!
    var isSwiping:Bool!
    var red:CGFloat!
    var green:CGFloat!
    var blue:CGFloat!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func saveImage(sender: AnyObject) {
        
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!,self, Selector("image:withPotentialError:contextInfo:"), nil)
        
    }
    @IBAction func undoDrawing(sender: AnyObject) {
        
        self.imageView.image = nil
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        red   = (0.0/255.0)
        green = (0.0/255.0)
        blue  = (0.0/255.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touching: Set<UITouch>, withEvent event: UIEvent?){
        
        isSwiping    = false
        if let touch = touching.first{
            
            mostRecent = touch.locationInView(imageView)
        }
    }
    
    override func touchesMoved(touching: Set<UITouch>, withEvent event: UIEvent?){
        
        isSwiping = true;
        if let touch = touching.first{
            let currentPoint = touch.locationInView(imageView)
            
            UIGraphicsBeginImageContext(self.imageView.frame.size)
            
            self.imageView.image?.drawInRect(CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height))
            
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), mostRecent.x, mostRecent.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(),CGLineCap.Round)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 9.0)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(),red, green, blue, 1.0)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            mostRecent = currentPoint
        }
    }
    
    override func touchesEnded(touching: Set<UITouch>, withEvent event: UIEvent?){
        
        if(!isSwiping) {
            UIGraphicsBeginImageContext(self.imageView.frame.size)
            self.imageView.image?.drawInRect(CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height))
            
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), CGLineCap.Round)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 9.0)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), mostRecent.x, mostRecent.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), mostRecent.x, mostRecent.y)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
    
    func image(image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafePointer<()>) {
        
        //UIAlertView(title: nil, message: "Image successfully saved to Photos library", delegate: nil, cancelButtonTitle: "Dismiss").show()
        let alert = UIAlertController(title: "", message:"Image successfully saved to Photos library", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        self.presentViewController(alert, animated: true){}
    }
}


