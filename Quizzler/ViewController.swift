//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestion = QuestionBank()
    var userAnswer : Bool = false
    var questionNumber = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            userAnswer = true
        }else if sender.tag == 2 {
            userAnswer = false
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
        
        
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber+1) / 13"
        let width = ((questionNumber + 1) * Int(view.frame.width) ) / 13
        progressBar.frame.size.width = CGFloat(width)
        
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
        questionLabel.text = allQuestion.list[questionNumber].questionText
        updateUI()
        }else{
            let alert = UIAlertController(title: "Awesome", message: "You have finish all the question , Do you want to start over ?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func checkAnswer() {
        let correctAnswer = allQuestion.list[questionNumber].answer
        if userAnswer == correctAnswer {
        ProgressHUD.showSuccess("True")
            score += 1
        }else{
           ProgressHUD.showError("False")
        }
    }
    
    
    func startOver() {
       questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
