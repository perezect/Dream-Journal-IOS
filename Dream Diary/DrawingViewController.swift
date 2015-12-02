//
//  DrawingViewController.swift
//  Dream Diary
//
//  Created by Felis Perez on 11/18/15.
//
//


import UIKit

class DrawingViewController: UIViewController {
    
    // Data members
    var mostRecent:CGPoint!
    var isSwiping:Bool!
    var red:CGFloat!
    var green:CGFloat!
    var blue:CGFloat!
    var drawing: UIImage!
    var brushSize: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var drawingImageView: UIImageView!
    
    @IBAction func saveImage(sender: AnyObject) {
        
        //UIImageWriteToSavedPhotosAlbum(self.imageView.image!,self, Selector("image:withPotentialError:contextInfo:"), nil)
        
        
    }
    @IBAction func undoDrawing(sender: AnyObject) {
        
        self.imageView.image = nil
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        drawing = self.imageView.image!
        //let dreamVC = segue.destinationViewController as! DreamViewController
        //dreamVC.drawing = self.imageView.image!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        red   = (0.0/255.0)
        green = (0.0/255.0)
        blue  = (0.0/255.0)
        
        imageView.image = drawing
        print("loaded image")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touching: Set<UITouch>, withEvent event: UIEvent?){
        
        isSwiping    = false
        if let touch = touching.first{
            
            mostRecent = touch.locationInView(drawingImageView)
        }
    }
    
    func drawLine(starting: CGPoint, ending: CGPoint) {
        
        // Draw a line between 2 points while dragging across the screen
        // Helper function for when touches move across the screen, and
        // for when writing to the permenant image during the touchesEnded function
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        drawingImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        CGContextMoveToPoint(context, starting.x, starting.y)
        CGContextAddLineToPoint(context, ending.x, ending.y)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, brushSize)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        CGContextStrokePath(context)
        drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        drawingImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(touching: Set<UITouch>, withEvent event: UIEvent?){
        
//        isSwiping = true;
//        if let touch = touching.first{
//            let currentPoint = touch.locationInView(drawingImageView)
//            
//            UIGraphicsBeginImageContext(self.drawingImageView.frame.size)
//            
//            self.drawingImageView.image?.drawInRect(CGRectMake(0, 0, self.drawingImageView.frame.size.width, self.drawingImageView.frame.size.height))
//            
//            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), mostRecent.x, mostRecent.y)
//            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
//            CGContextSetLineCap(UIGraphicsGetCurrentContext(),CGLineCap.Round)
//            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 9.0)
//            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(),red, green, blue, 1.0)
//            CGContextStrokePath(UIGraphicsGetCurrentContext())
//            self.drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            mostRecent = currentPoint
//        }
        isSwiping = true
        if let touch = touching.first {
            let current = touch.locationInView(view)
            drawLine(mostRecent, ending: current)
            mostRecent = current
        }
    }
    
    override func touchesEnded(touching: Set<UITouch>, withEvent event: UIEvent?){
        
//        if(!isSwiping) {
//            UIGraphicsBeginImageContext(self.imageView.frame.size)
//            self.imageView.image?.drawInRect(CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height))
//            
//            CGContextSetLineCap(UIGraphicsGetCurrentContext(), CGLineCap.Round)
//            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 9.0)
//            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0)
//            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), mostRecent.x, mostRecent.y)
//            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), mostRecent.x, mostRecent.y)
//            CGContextStrokePath(UIGraphicsGetCurrentContext())
//            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//        }
        if !isSwiping {
            // draw a single point
            drawLine(mostRecent, ending: mostRecent)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        drawingImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        drawingImageView.image = nil
    }
    
    func image(image: UIImage, withPotentialError error: NSErrorPointer, contextInfo: UnsafePointer<()>) {
        
        //UIAlertView(title: nil, message: "Image successfully saved to Photos library", delegate: nil, cancelButtonTitle: "Dismiss").show()
        let alert = UIAlertController(title: "", message:"Image successfully saved to Photos library", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        self.presentViewController(alert, animated: true){}
    }
}


