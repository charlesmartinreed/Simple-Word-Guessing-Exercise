//
//  ViewController.swift
//  ApplePie
//
//  Created by Charles Martin Reed on 10/8/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        // begin with empty string
        var guessedWord = ""
        
        // loop through each character of word
        for letter in word {
            // if letter is in guessedLetters, convert to string, append the letter onto the variable
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                //otherwise, the placeholder character of "_" should be displayed
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    // receive a character, add it to the guessedLetters collection, update incorrectMovesRemaining if needed
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}

class ViewController: UIViewController {
    
    //MARK:- Properties
    var listOfWords = ["denizen", "clearway", "frequent", "physique", "residual", "quandary", "temecula", "bloviate", "aardvark", "undulate", "gerrymander", "vituperate"]
    var incorrectMovesAllowed = 7
    
    var currentGame: Game! // because there's no value here between app launch and the beginning of the first round, we force unwrap
    
    // whether a round is won or lost, a newRound will be triggered
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    //MARK:- IBOulets
    @IBOutlet weak var treeImageVIew: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Initial round
        newRound()
    }
    
    //MARK: IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        // 1. Read button's title
        // 2. Determine if letter is in word for game round
        
        sender.isEnabled = false // works without typecasting because this is explictly set to UIButton
        if let letterString = sender.title(for: .normal) {
            // if let because not all buttons have titles
            let letter = Character(letterString.lowercased())
            currentGame.playerGuessed(letter: letter)
            updateGameState()
        }
    }
    
    //MARK: Round building
    func newRound() {
        
        // make sure that listOfWords is NOT EMPTY
        if !listOfWords.isEmpty {
            
            // 1. Select a new word
            // 2. reset incorrectMovesAllowed
            // 3. renable letter buttons at round outset
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
        
        
    }
    
    //MARK: UI alterations
    func updateUI() {
        // create an array of String objects, add the characters of the round's word as strings to that array, join the characters into a single string, seperated by spaces
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageVIew.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable // true or false depending on when called
        }
    }
    
    //MARK: Game state logic
    func updateGameState() {
        // if no more guesses, game is lost
        // if the word chosen at beginning of round equals the word built by the user's choices, game is won
        // in all other cases, the game is on-going so update the UI
        
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    


}

