//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: TimerBuilder?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer = TimerBuilder(hardness: sender.currentTitle!)
        if let time = timer?.time {
            print(time)
        }
     
    }
}
