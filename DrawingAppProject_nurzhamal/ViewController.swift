//
//  ViewController.swift
//  DrawingAppProject_nurzhamal
//
//  Created by Ainur on 10/30/17.
//  Copyright © 2017 Ainur. All rights reserved.
//

import UIKit
import Social


class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var swiped = false
    
    var red:CGFloat = 0.0
    var green:CGFloat = 0.0
    var blue:CGFloat = 0.0
    
    var brushSize:CGFloat = 5.0
    var opacityValue:CGFloat = 1.0
    
    var isDrawing = true
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = false
        
        if let touch  = touches.first{
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLines(fromPoint:CGPoint,toPoint:CGPoint){
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x:0, y:0, width:self.view.frame.width,height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x:fromPoint.x, y:fromPoint.y))
        context?.addLine(to: CGPoint(x:toPoint.x, y:toPoint.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushSize)
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacityValue).cgColor)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true
        
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    @IBAction func colorsPicked(_ sender: AnyObject) {
        if sender.tag == 0 {
            (red,green,blue) = (1,0,0)
        } else if sender.tag == 1 {
            (red,green,blue) = (0,0,0)
        } else if sender.tag == 2 {
            (red,green,blue) = (0,1,0)
        } else if sender.tag == 3 {
            (red,green,blue) = (0,0,1)
        } else if sender.tag == 4 {
            (red,green,blue) = (1,0.76,0.86)
        } else if sender.tag == 5 {
            (red,green,blue) = (1,0.5,0)
        } else if sender.tag == 6 {
            (red,green,blue) = (0.41,0.06,0.5)
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        self.imageView.image = nil
    }
    @IBAction func save(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Pick your option", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Pick an image", style: .default, handler: { (_) in
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Save your drawing", style: .default, handler: { (_) in
            if let image = self.imageView.image {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func tweetButton(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            
            let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            self.present(tweetShare, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func erase(_ sender: Any) {
        if(isDrawing) {
            (red, green, blue) = (1, 1, 1)
        }
        
        isDrawing = !isDrawing
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let settingsVC = segue.destination as! SettingsVC
        settingsVC.delegate = self
        settingsVC.red = red
        settingsVC.green = green
        settingsVC.blue = blue
        settingsVC.brushSize = brushSize
        settingsVC.opacityValue = opacityValue
    }

}

extension ViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate, SettingsVCDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.selectedImage = imagePicked
            self.imageView.image = selectedImage
            
            dismiss(animated: true,completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func settingsViewCotrollerDidFinish(_ settingsVC: SettingsVC) {
        self.red = settingsVC.red
        self.blue = settingsVC.blue
        self.green = settingsVC.green
        self.brushSize = settingsVC.brushSize
        self.opacityValue = settingsVC.opacityValue
    }
}
