//
//  TextToSpeechManager.swift
//  WDIC
//
//  Created by 이융의 on 12/19/23.
//

import Foundation
import AVFoundation

class TextToSpeechManager {
    static let shared = TextToSpeechManager()
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN") // 중국어 발음을 위한 설정
        utterance.rate = 0.3
        speechSynthesizer.stopSpeaking(at: .immediate)
        speechSynthesizer.speak(utterance)
    }
    func stop() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
}
