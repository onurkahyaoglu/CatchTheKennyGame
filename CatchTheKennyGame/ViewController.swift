//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Onur Kahyaoğlu on 27.01.2020.
//  Copyright © 2020 Onur Kahyaoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var highScore = 0
    var timer = Timer()
    var counter = 10
    var mrbeArray = [UIImageView]()
    var hideTimer = Timer()
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblHighScore: UILabel!
    
    
    @IBOutlet weak var mrbe1: UIImageView!
    @IBOutlet weak var mrbe2: UIImageView!
    @IBOutlet weak var mrbe3: UIImageView!
    @IBOutlet weak var mrbe4: UIImageView!
    @IBOutlet weak var mrbe5: UIImageView!
    @IBOutlet weak var mrbe6: UIImageView!
    @IBOutlet weak var mrbe7: UIImageView!
    @IBOutlet weak var mrbe8: UIImageView!
    @IBOutlet weak var mrbe9: UIImageView!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblScore.text = "Score: \(score)"
        //HighScore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "HighScore")
        if storedHighScore == nil {
            highScore = 0
            lblHighScore.text = "High Score: \(highScore)"
        }
        
        if let newHighScore = storedHighScore as? Int {
            highScore = newHighScore
            lblHighScore.text = "High Score: \(highScore)"
        }
        lblHighScore.text = "High Score: \(highScore)"
        
        lblTime.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideMrbe), userInfo: nil, repeats: true)
        
        mrbe1.isUserInteractionEnabled = true
        mrbe2.isUserInteractionEnabled = true
        mrbe3.isUserInteractionEnabled = true
        mrbe4.isUserInteractionEnabled = true
        mrbe5.isUserInteractionEnabled = true
        mrbe6.isUserInteractionEnabled = true
        mrbe7.isUserInteractionEnabled = true
        mrbe8.isUserInteractionEnabled = true
        mrbe9.isUserInteractionEnabled = true

        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        mrbe1.addGestureRecognizer(recognizer1)
        mrbe2.addGestureRecognizer(recognizer2)
        mrbe3.addGestureRecognizer(recognizer3)
        mrbe4.addGestureRecognizer(recognizer4)
        mrbe5.addGestureRecognizer(recognizer5)
        mrbe6.addGestureRecognizer(recognizer6)
        mrbe7.addGestureRecognizer(recognizer7)
        mrbe8.addGestureRecognizer(recognizer8)
        mrbe9.addGestureRecognizer(recognizer9)
        
        mrbeArray = [mrbe1, mrbe2, mrbe3, mrbe4, mrbe5, mrbe6, mrbe7, mrbe8, mrbe9]
        hideMrbe()
        
    }
    @objc func hideMrbe() {
        for mrbe in mrbeArray {
            mrbe.isHidden = true
        }
        let selectedNum = Int(arc4random_uniform(UInt32(mrbeArray.count - 1)))
        
        mrbeArray[selectedNum].isHidden = false
        
    }
    @objc func increaseScore(){
        score += 1
        lblScore.text = "Score: \(score)"
        if score > highScore {
            highScore = score
            lblHighScore.text = "High Score: \(highScore)"
            UserDefaults.standard.set(highScore, forKey: "HighScore")
            
        }

    }
    
    @objc func timerFunction(){
        counter -= 1
        lblTime.text = "\(counter)"
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for mrbe in mrbeArray {
                mrbe.isHidden = true
            }
            
            
            makeAlert(title: "Warning" , message: "Time is up")
           
        }
    
    }
    func makeAlert(title: String, message: String){
         let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
         let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
         alert.addAction(okButton)
        let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.score = 0
            self.lblScore.text = "Score: \(self.score)"
            self.counter = 10
            self.lblTime.text = String(self.counter)
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
            
            self.hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hideMrbe), userInfo: nil, repeats: true)
        }
        
    
    
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
     }
    

}

