//
//  SettingsVC.swift
//  DrawingAppProject_nurzhamal
//
//  Created by Aknur Sh on 11/7/17.
//  Copyright © 2017 Ainur. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    
    @IBOutlet var brushSizeLabel: UILabel!
    @IBOutlet var opacityLabel: UILabel!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var imageView: UIImageView!
    var red:CGFloat = 0.0
    var green:CGFloat = 0.0
    var blue:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
    }
    
    @IBAction func brushSizeChanged(_ sender: Any) {
    }
    @IBAction func opacityCanged(_ sender: Any) {
    }
    @IBAction func redSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        red = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        redLabel.text = "\(slider.value = 255)"
    }
    @IBAction func greenSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        green = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        greenLabel.text = "\(slider.value = 255)"
    }
    @IBAction func blueSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        blue = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        blueLabel.text = "\(slider.value = 255)"
    }
    
    func drawPreview(red: CGFloat, green: CGFloat, blue: CGFloat ){
        imageView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
