//
//  LessonPronView.swift
//  WDIC
//
//  Created by 이융의 on 11/21/23.
//

import SwiftUI

struct LessonPronView: View {
    @EnvironmentObject var viewModel: LessonViewModel

    @Environment(\.presentationMode) var presentationMode
        
    @State private var currentIndex: Int = 0
    
    private var totalCards: Int {
        viewModel.pronunciation?.count ?? 0
    }
    
    private var progress: CGFloat {
        CGFloat(currentIndex + 1) / CGFloat(totalCards)
    }
    @State private var showingCompleteView: Bool = false
    @State private var isDataReady = false

    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center) {
                Spacer()
                titleView
                .padding(.top)

                Text("\(currentIndex + 1) / \(totalCards)")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 50)
                    .padding(.top, 5)
                                
                PronContentView(currentIndex: $currentIndex, totalCards: totalCards)
                    .environmentObject(viewModel)
                    .padding(.top)
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "발음"))
            if currentIndex > totalCards - 1 {
                CompletePronView()
                    .environmentObject(viewModel)
            }

        }
        .onAppear {
            // 백엔드 대신 Mock 데이터 사용
            viewModel.setupMockData()
            isDataReady = true
            // 첫 번째 문장 TTS 자동 실행
            if let sentence = viewModel.pronunciation?.first?.sentence {
                TextToSpeechManager.shared.speak(text: sentence)
            }
            
            // 원래 코드 - 필요할 때 주석 해제
            // viewModel.fetchLessonPart(partType: "pronunciation")
        }
        .onChange(of: viewModel.pronunciation?.count) { _ in
            isDataReady = true
            if let sentence = viewModel.pronunciation?[currentIndex].sentence {
                TextToSpeechManager.shared.speak(text: sentence)
            }
        }
        .onChange(of: currentIndex) { _ in
            if isDataReady, let sentence = viewModel.pronunciation?[currentIndex].sentence {
                TextToSpeechManager.shared.speak(text: sentence)
            }
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    private var titleView: some View {
        VStack(alignment: .center) {
            Text("발음 연습하기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.white)
        }
    }
}
struct PronContentView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @StateObject private var audioRecorderPlayer = AudioRecorderPlayer()

    @Binding var currentIndex: Int
    var totalCards: Int

    @State private var isSpeaking: Bool = false
    @State private var isRecording: Bool = false
    @State private var step: Int = 0
    @State private var showingPermissionAlert = false

    var body: some View {
        VStack {
            pronText
            toolButtonView
        }
        .alert(isPresented: $showingPermissionAlert) { permissionAlert }
    }
    
    private var pronText: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Text(viewModel.pronunciation?[safe: currentIndex]?.pinyin ?? "Default pinyin")
                .font(.subheadline)
                .fontWeight(.light)
            
            Text(viewModel.pronunciation?[safe:currentIndex]?.sentence ?? "Default sentence")
                .font(.headline)
            Text(viewModel.pronunciation?[safe:currentIndex]?.translation ?? "Default translation")
                .font(.headline)
            
            // tts 다시 재생 버튼
            Button(action: {
                isSpeaking.toggle()
                if isSpeaking {
                    TextToSpeechManager.shared.speak(text: viewModel.pronunciation?[currentIndex].sentence ?? "Default sentence")
                } else {
                    TextToSpeechManager.shared.stop()
                }
            }) {
                Image(systemName: "speaker.wave.2.fill")
                    .foregroundColor(Color.Color6)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 40)
    }

    private var feedbackText: some View {
        VStack {
            if step == 0 {
                feedbackTextView(text: "들어보세요.")
            } else if step == 1 {
                feedbackTextView(text: "따라해보세요.")
            } else if step == 2 {
                feedbackTextView(text: "다시 시도해보세요.")
            } else {
                feedbackTextView(text: "참 잘했어요!")
            }
        }
    }

    private func feedbackTextView(text: String) -> some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .scaleEffect(isRecording ? 1.1 : 0.9)
            .animation(.easeInOut(duration: 0.5))
    }

    private var permissionAlert: Alert {
        Alert(
            title: Text("Microphone Access Required"),
            message: Text("This app requires access to your microphone for recording. Please enable microphone access in your device settings."),
            dismissButton: .default(Text("Settings")) {
                // Open the settings app
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        )
    }

    
    private var toolButtonView: some View {
        VStack {
            Spacer()
            feedbackText
            VStack(alignment: .center) {
                HStack {
                    Button(action: audioRecorderPlayer.startPlayback) {
                        Image(systemName: "waveform.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.Color4)
                    }

                    Spacer()
                    
                    // Record/Stop button
                    Button(action: {
                        self.audioRecorderPlayer.checkMicrophonePermission { granted in
                            if granted {
                                withAnimation {
                                    self.isRecording.toggle()
                                    if self.isRecording {
                                        self.audioRecorderPlayer.startRecording()
                                        self.step = 1
                                    } else {
                                        self.audioRecorderPlayer.stopRecording()
                                        self.step = 3
                                    }
                                }
                            } else {
                                self.showingPermissionAlert = true
                                print("Microphone access denied")
                            }
                        }
                    }) {
                        Image(systemName: self.isRecording ? "mic.circle.fill" : "mic.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(self.isRecording ? Color.Color2 : Color.Color4)
                            .scaleEffect(self.isRecording ? 1.1 : 1.0)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Spacer()
                    
                    // 다음 문장으로 이동 버튼
                    Button(action: {
                        if currentIndex < totalCards {
                            print("currentIndex: \(self.currentIndex)")
                            print("totalCards: \(self.totalCards)")

                            self.currentIndex += 1
                            self.step = 0
                        }
                    }) {
                        Image(systemName: "play.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.Color4)
                    }

                }
                .padding()
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}



#Preview {
    LessonPronView()
}

