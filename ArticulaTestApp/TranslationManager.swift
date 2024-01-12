//
//  TranslationManager.swift
//  Utopic Lite
//
//  Created by Omer Dogan on 15.04.2020.
//  Copyright © 2020 Desi. All rights reserved.
//

import Foundation

let gTranslations = TranslationManager()

class TranslationManager {
    
    /// variables
    private var json:Raw?
    public var selectedLanguageIndex:Int = 0

    struct Raw : Codable {
        let version : String
        let translations : [Translation]
    }
    struct Translation : Codable{
        let id : String
        let name : String
        let words : [String:String]
    }
    
    // Initialization
    fileprivate init() {
       readText()
    }
    
    private func readText(){
        do {
            if let path = Bundle.main.path(forResource: "Translations", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    parseJson(raw: data)
                } catch {
                }
            }
        }
        catch { print("Error -> \(error)") }
    }
    
    private func parseJson(raw:Data){
        do {
           json = try JSONDecoder().decode(Raw.self, from: raw)
            print("TRANSLATION VERSION : \(json?.version)")
        } catch {
           print("TRANSLATION parseJson ERROR \(error)")
        }
        
        //let str = String(decoding: raw, as: UTF8.self)
        //print(str)
    }
    
    public func selectLanguage(index:Int){
        var ind = index
        // iOSta geriye uyumluluk icin ayarlandi
        if(ind == 1){
            ind = 0
        }
        else if(ind == 0){
            ind = 1
        }
        
        selectedLanguageIndex = ind
    }
    
    public func getWord(key:String) -> String {
        print(json?.translations);
        var word = json?.translations[selectedLanguageIndex].words[key]
        
        // Kelime null ise
        if(word == nil){
            
            // ingilizecesini al
            word = json?.translations[1].words[key]
            
            if(word == nil){
                word = "NO-TRANSLATION"
            }
        }
        
        return word!
    }
    
    func getLanguageCount() -> Int {
        return (json?.translations.count)!
    }
    
    func getLanguageName(index:Int) -> String {
        
        var ind = index
        // iOSta geriye uyumluluk icin ayarlandi
        if(ind == 1){
            ind = 0
        }
        else if(ind == 0){
            ind = 1
        }
        
        return (json?.translations[ind].name)!
    }
}
