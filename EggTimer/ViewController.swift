//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var eggTimer: EggTimer?
    private var secondsPassed: Float = 0.0
    private var timerState: Bool = false
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.isHidden = true
        titleLabel.text = "How do you like your eggs?"
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {

        // 기존의 타이머가 켜져있다면 끈다.
        if timerState{
            eggTimer?.endTimer()
        }
        
        // 타이머를 생성하고 시작한다.
        guard let hardness = sender.currentTitle else { return }
        prepare(hardness)
    }
    
    func prepare(_ hardness: String) {
        timeLabel.isHidden = false
        titleLabel.text = hardness
        secondsPassed = 0.0
        progressView.setProgress(0.0, animated: false)
        
        eggTimer = EggTimerBuilder(hardness: hardness)
                    .setTimerFireMethod(handler: timerFireMethod)
                    .build()
        eggTimer?.delegate?.viewController = self
        titleLabel.text = hardness
        eggTimer?.startTimer()
    }
    
    func changeTimerStatus() {
        timerState = !timerState
    }
    
}

extension ViewController {
    
    // tapped event 
    func timerFireMethod (currentTimer: Timer) -> Void {
        guard let totalSeconds = eggTimer?.totalTime else { return }
        if secondsPassed < totalSeconds {
            timeLabel.text = String(Int(totalSeconds - secondsPassed))
            progressView.setProgress(progressPercentages(secondsPassed, totalSeconds), animated: true)
            secondsPassed += 1
            
        } else {
            // 0초가 되었을 때
            currentTimer.invalidate()
            changeTimerStatus()
            titleLabel.text = "the egg is ready!"
            progressView.setProgress(1.0, animated: true)
            timeLabel.isHidden = true
        }
    }
    
    private func progressPercentages (_ secondsPassed: Float, _ totalSeconds: Float) -> Float {
        return secondsPassed/totalSeconds
    }
}
