//
//  ViewController.swift
//  ArticulaTestApp
//
//  Created by arge-macbook-air on 9.01.2024.
//
import Foundation
import UIKit


class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var outputTextLabel: UILabel!
    @IBOutlet weak var pushBtn: UIButton!
    @IBOutlet weak var inputText: UITextView!
    @IBOutlet weak var turkishButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var spanishButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Make UITextView transparent
        inputText.alpha = 0.5
        // Set UITextView's delegate
        inputText.delegate = self
        // Assign the user a default text to enter text
        inputText.textColor = UIColor.gray
        gTranslations.selectedLanguageIndex = 0 // Default: Turkish
        applyButtonSize()
        applyTranslations()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if inputText.textColor == UIColor.gray {
            inputText.text = nil
            inputText.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if inputText.text.isEmpty {
            inputText.accessibilityHint = gTranslations.getWord(key: "actTextField")
            inputText.textColor = UIColor.gray
            
        }
    }

    
    
    func applyTranslations() {
        inputLabel.text = gTranslations.getWord(key: "actInput")
        outputLabel.text = gTranslations.getWord(key: "actOutput")
        inputText.text = gTranslations.getWord(key: "actTextField")
        //pushBtn.setTitle(gTranslations.getWord(key: "actPush"), for: .normal)
    }
    
   
        func applyButtonSize() { // Increase the size of the selected button
            turkishButton.transform = gTranslations.selectedLanguageIndex == 0 ? CGAffineTransform(scaleX: 1.2, y: 1.2) : CGAffineTransform(scaleX: 1, y: 1)
            englishButton.transform = gTranslations.selectedLanguageIndex == 1 ? CGAffineTransform(scaleX: 1.2, y: 1.2) : CGAffineTransform(scaleX: 1, y: 1)
            spanishButton.transform = gTranslations.selectedLanguageIndex == 2 ? CGAffineTransform(scaleX: 1.2, y: 1.2) : CGAffineTransform(scaleX: 1, y: 1)
        }
    
    @IBAction func englishTranslateButton(_ sender: UIButton) {
        
        gTranslations.selectedLanguageIndex = 1
        applyTranslations()
        applyButtonSize()
        inputText.text = gTranslations.getWord(key: "actTextField") // Placeholder text in new language
        inputText.textColor = UIColor.gray
    }
    
    @IBAction func turkishTranslateButton(_ sender: UIButton) {
        
        gTranslations.selectedLanguageIndex = 0
        applyTranslations()
        applyButtonSize()
        inputText.text = gTranslations.getWord(key: "actTextField") // Placeholder text in new language
        inputText.textColor = UIColor.gray
    }
    
    @IBAction func spanishTranslateButton(_ sender: UIButton) {
        
        gTranslations.selectedLanguageIndex = 2
        applyTranslations()
        applyButtonSize()
        inputText.text = gTranslations.getWord(key: "actTextField") // Placeholder text in new language
        inputText.textColor = UIColor.gray

    }
    
    @IBAction func separateButtonTapped(_ sender: UIButton) {
        if let text = inputText.text {
            
            let seperatedText = separateConjunctions(from: text)
            outputTextLabel.text = seperatedText
            
        }
    }
    
    func separateConjunctions(from text: String) -> String {
        var conjunctions = [" and ", " ve ", " if ", " si ", "eğer", "And", "Si", "If", "Eğer"]
        switch gTranslations.selectedLanguageIndex {
        case 0:
            conjunctions = ["ve", "eğer"] // TI
        case 1:
            conjunctions = ["and", "if", "If", "And"]
            break
        case 2: 
            conjunctions = ["Si", "Y", "si", "y"]
            break
            
        default:
            conjunctions = [" and ", " ve ", " if ", " si ", "eğer", "And", "Si", "If", "Eğer"]
        }
        var separatedText = text

        for conjunction in conjunctions {
            while let range = separatedText.range(of: conjunction) {
                let firstPart = separatedText[..<range.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
                let secondPart = separatedText[range.upperBound...].trimmingCharacters(in: .whitespacesAndNewlines)
                separatedText = "\(firstPart)\n\(secondPart)"
            }
        }

        return separatedText
    }

    
}

