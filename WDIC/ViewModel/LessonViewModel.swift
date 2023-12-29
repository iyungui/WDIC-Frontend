//
//  LessonViewModel.swift
//  WDIC
//
//  Created by 이융의 on 12/19/23.
//

import Foundation
import Combine

class LessonViewModel: ObservableObject {
    @Published var lessonId: String
    @Published var vocabulary: [Vocabulary]? = nil
    @Published var sentences: [Sentence]? = nil
    @Published var pronunciation: [Pronunciation]? = nil
    @Published var writing: [Writing]? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private var lessonService: LessonService
    private var cancellables = Set<AnyCancellable>()

    // Include lessonId in the initializer
    init(lessonId: String, lessonService: LessonService = LessonService()) {
        self.lessonId = lessonId
        self.lessonService = lessonService
    }

    func fetchLessonPart(partType: String) {
        isLoading = true
        errorMessage = nil

        lessonService.getLessonPart(lessonId: self.lessonId, partType: partType) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let content):
//                    print("\(self?.lessonId ?? "") success load lessons")
//                    print("Raw data: \(String(describing: content))")
                    self?.updateContent(with: content, partType: partType)
                case .failure(let error):
                    print("\(self?.lessonId ?? "") fail load lessons")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // Additional function to update the lessonId
    func updateLessonId(newLessonId: String) {
        self.lessonId = newLessonId
    }

    private func updateContent(with content: Any, partType: String) {
        print("Attempting to update content for partType: \(partType)")

        switch partType {
        case "vocabulary":
            guard let vocabularyData = content as? [Vocabulary] else {
                errorMessage = "Invalid data format received for vocabulary"
                return
            }
            vocabulary = vocabularyData
//            print("Vocabulary updated: \(String(describing: vocabulary))")
        case "sentences":
            guard let sentencesData = content as? [Sentence] else {
                errorMessage = "Invalid data format received for sentences"
                return
            }
            sentences = sentencesData
        case "pronunciation":
            guard let pronunciationData = content as? [Pronunciation] else {
                errorMessage = "Invalid data format received for pronunciation"
                return
            }
            pronunciation = pronunciationData
        case "writing":
            guard let writingData = content as? [Writing] else {
                errorMessage = "Invalid data format received for writing"
                return
            }
            writing = writingData
        default:
            errorMessage = "Unknown part type"
        }
    }
}


