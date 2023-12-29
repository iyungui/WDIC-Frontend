//
//  ChapterViewModel.swift
//  WDIC
//
//  Created by 이융의 on 12/19/23.
//

import Foundation
import Combine

class ChapterViewModel: ObservableObject {
    @Published var chapters: [Chapter] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var chapterService = ChapterService()

    func fetchChapters() {
        isLoading = true
        errorMessage = nil
        chapterService.getChapters { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let chapters):
                    self?.chapters = chapters
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
