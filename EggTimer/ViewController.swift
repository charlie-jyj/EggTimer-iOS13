//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isTimerStart: Bool = false
    private var eggTimer: EggTimer?
    private var secondsRemaining: Int?
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.isHidden = true
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        titleLabel.text = "How do you like your eggs?"
        guard let hardness = sender.currentTitle else { return }
        
        if isTimerStart {
            // 기존의 타이머가 켜져있다면 끈다.
            eggTimer?.endTimer()
        }
        
        // 타이머를 생성하고 시작한다.
        eggTimer = EggTimerBuilder(hardness: hardness)
                    .setTimerFireMethod(handler: timerFireMethod)
                    .build()
        eggTimer?.delegate?.viewController = self
        eggTimer?.startTimer()
        
        guard let time = eggTimer?.totalTime else { return }
        timeLabel.isHidden = false
        timeLabel.text = String(time)
        progressView.setProgress(0.0, animated: true)
    }
    
    func changeTimerStatus() {
        self.isTimerStart = !isTimerStart
    }
    
    func setSecondsRemaining(from seconds: Int) {
        self.secondsRemaining = seconds
    }
    
}

extension ViewController {
    
    // tapped event 
    func timerFireMethod (currentTimer: Timer) -> Void {
        if let seconds = secondsRemaining, seconds > 0, let totalSeconds = eggTimer?.totalTime {
            timeLabel.text = String(seconds)
            print((Double(totalSeconds)-Double(seconds))/Double(totalSeconds))
            progressView.setProgress(Float((Double(totalSeconds)-Double(seconds))/Double(totalSeconds)), animated: true)
            secondsRemaining = seconds-1 // 1초 감소
           
        } else {
            // 0초가 되었을 때
            titleLabel.text = "the egg is ready!"
            currentTimer.invalidate()
            changeTimerStatus() // True -> False
            progressView.setProgress(0.0, animated: true)
            timeLabel.isHidden = true
        }
    }
}
