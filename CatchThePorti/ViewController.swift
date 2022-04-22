//
//  ViewController.swift
//  CatchThePorti
//
//  Created by Sencer Bulut on 21.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var portiArray = [UIImageView] ()
    var hideTimer = Timer()
    var highScore = 0
    

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var porti1: UIImageView!
    @IBOutlet weak var porti2: UIImageView!
    @IBOutlet weak var porti3: UIImageView!
    @IBOutlet weak var porti4: UIImageView!
    @IBOutlet weak var porti5: UIImageView!
    @IBOutlet weak var porti6: UIImageView!
    @IBOutlet weak var porti7: UIImageView!
    @IBOutlet weak var porti8: UIImageView!
    @IBOutlet weak var porti9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore = \(highScore)"

        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore = \(highScore)"
        }
        
        porti1.isUserInteractionEnabled = true
        porti2.isUserInteractionEnabled = true
        porti3.isUserInteractionEnabled = true
        porti4.isUserInteractionEnabled = true
        porti5.isUserInteractionEnabled = true
        porti6.isUserInteractionEnabled = true
        porti7.isUserInteractionEnabled = true
        porti8.isUserInteractionEnabled = true
        porti9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer (target: self, action: #selector(increaseScore))
        
        porti1.addGestureRecognizer(recognizer1)
        porti2.addGestureRecognizer(recognizer2)
        porti3.addGestureRecognizer(recognizer3)
        porti4.addGestureRecognizer(recognizer4)
        porti5.addGestureRecognizer(recognizer5)
        porti6.addGestureRecognizer(recognizer6)
        porti7.addGestureRecognizer(recognizer7)
        porti8.addGestureRecognizer(recognizer8)
        porti9.addGestureRecognizer(recognizer9)
        
        portiArray = [porti1, porti2, porti3, porti4, porti5, porti6, porti7, porti8, porti9]
        
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidePorti), userInfo: nil, repeats: true)
        
        hidePorti()
    
    }
    
    @objc func hidePorti() {
        
        for porti in portiArray {
            porti.isHidden = true
            
            
        }
        
        let random = Int(arc4random_uniform(UInt32(portiArray.count - 1)))
        portiArray[random].isHidden = false
        
    }
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    
        
        @objc func countDown() {
            
            counter -= 1
            timeLabel.text = String(counter)
            
            if counter == 0 {
                timer.invalidate()
                hideTimer.invalidate()
                
                for porti in portiArray {
                    porti.isHidden = true
                    }
                
                if self.score > self.highScore {
                    self.highScore = self.score
                    highscoreLabel.text = "Highscore: \(self.highScore)"
                    UserDefaults.standard.set(self.highScore, forKey: "highscore")
                }
                
                
                let alert = UIAlertController (title: "Time's Up", message: "Do you want again?", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {  UIAlertAction in
                    
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                        
                    
                }
                let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                    
                    self.score = 0
                    self.scoreLabel.text = "Score : \(self.score)"
                    self.counter = 10
                    self.timeLabel.text = String(self.counter)
                    
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                    self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidePorti), userInfo: nil, repeats: true)
                    
                    
                    
                
                }
                
                alert.addAction(okButton)
                alert.addAction(replayButton)
                self.present(alert, animated: true, completion: nil)
            
            }
                
            
        }
        

}


