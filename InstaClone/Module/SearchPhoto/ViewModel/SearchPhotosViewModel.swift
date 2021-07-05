//
//  SearchPhotosViewModel.swift
//  InstaClone
//
//  Created by Yaman Boztepe on 2.07.2021.
//

import Foundation

class SearchPhotosViewModel: BaseViewModel {
    
    // MARK: - Check Text
    func check(text: String?) throws {
        guard let text = text, text != "" else { throw SearchTextError.NilText }
        
        let invalidCharacters = CharacterSet(charactersIn: "\\/:*?\"<>|")
            .union(.newlines)
            .union(.illegalCharacters)
            .union(.controlCharacters)
            .union(.symbols)
            .union(.decimalDigits)
        
            if text.rangeOfCharacter(from: invalidCharacters) != nil {
                throw SearchTextError.InvalidText
            }
        
    }
}

