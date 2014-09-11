//
//  KeyboardModel.swift
//  TransliteratingKeyboard
//
//  Created by Alexei Baboulevitch on 7/10/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

// temporary layout rules
//      - letters: side gap + standard size + gap size; side gap is flexible, and letters are centered
//      - special characters: size to width
//      - special keys: a few standard widths
//      - space and return: flexible spacing

import Foundation

var counter = 0

class Keyboard {
    var pages: [Page]
    
    init() {
        self.pages = []
    }
    
    func addKey(key: Key, row: Int, page: Int) {
        if self.pages.count <= page {
            for i in self.pages.count...page {
                self.pages.append(Page())
            }
        }
        
        self.pages[page].addKey(key, row: row)
    }
}

class Page {
    var rows: [[Key]]
    
    init() {
        self.rows = []
    }
    
    func addKey(key: Key, row: Int) {
        if self.rows.count <= row {
            for i in self.rows.count...row {
                self.rows.append([])
            }
        }

        self.rows[row].append(key)
    }
}

class Key: Hashable {
    enum KeyType {
        case Character
        case SpecialCharacter
        case Shift
        case Backspace
        case ModeChange
        case KeyboardChange
        case Period
        case Space
        case Return
    }
    
    var type: KeyType
    var outputText: String?
    var keyCap: String?
    var lowercaseKeyCap: String? {
        get {
            if keyCap == nil {
                return nil
            }
            else {
                return (keyCap! as NSString).lowercaseString
            }
        }
    }
    
    var hashValue: Int
    
    init(type: KeyType) {
        self.type = type
        self.hashValue = counter
        counter += 1
    }
}

func ==(lhs: Key, rhs: Key) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

func defaultKeyboard() -> Keyboard {
    var defaultKeyboard = Keyboard()
    
    for key in ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"] {
        var keyModel = Key(type: .Character)
        keyModel.keyCap = key
        keyModel.outputText = key
        defaultKeyboard.addKey(keyModel, row: 0, page: 0)
    }
    
    for key in ["A", "S", "D", "F", "G", "H", "J", "K", "L"] {
        var keyModel = Key(type: .Character)
        keyModel.keyCap = key
        keyModel.outputText = key
        defaultKeyboard.addKey(keyModel, row: 1, page: 0)
    }
    
    var keyModel = Key(type: .Shift)
    keyModel.keyCap = "⇪"
    defaultKeyboard.addKey(keyModel, row: 2, page: 0)
    
    for key in ["Z", "X", "C", "V", "B", "N", "M"] {
        var keyModel = Key(type: .Character)
        keyModel.keyCap = key
        keyModel.outputText = key
        defaultKeyboard.addKey(keyModel, row: 2, page: 0)
    }
    
    var keyModel2 = Key(type: .Backspace)
    keyModel2.keyCap = "⬅︎"
    defaultKeyboard.addKey(keyModel2, row: 2, page: 0)
    
    var keyModel3 = Key(type: .ModeChange)
    keyModel3.keyCap = "123"
    defaultKeyboard.addKey(keyModel3, row: 3, page: 0)
    
    var keyModel4 = Key(type: .KeyboardChange)
    keyModel4.keyCap = "🌐"
    defaultKeyboard.addKey(keyModel4, row: 3, page: 0)
    
    var keyModel5 = Key(type: .Space)
    keyModel5.keyCap = "space"
    keyModel5.outputText = " "
    defaultKeyboard.addKey(keyModel5, row: 3, page: 0)
    
//    var keyModel7 = Key(type: .Period)
//    keyModel7.keyCap = "."
//    keyModel7.outputText = "."
//    defaultKeyboard.addKey(keyModel7, row: 3)
    
    var keyModel6 = Key(type: .Return)
    keyModel6.keyCap = "return"
    keyModel6.outputText = "\n"
    defaultKeyboard.addKey(keyModel6, row: 3, page: 0)
    
    return defaultKeyboard
}
