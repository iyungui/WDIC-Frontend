# 🇨🇳 WDIC (Writing Documents In Chinese) - 중국어 학습 앱

<div align="center">
  <img src="https://github.com/user-attachments/assets/2f2fb81b-b010-4248-b38e-2952d9583b1b" alt="WDIC 로고" width="250">
  <br>
  <p><strong>중국어 단어, 문장, 발음, 작문 학습을 할 수 있는 앱</strong></p>
  <p>
    <a href="#-주요-기능">주요 기능</a> •
    <a href="#-기술-스택">기술 스택</a> •
    <a href="#-아키텍처">아키텍처</a> •
    <a href="#-설치-방법">설치 방법</a> •
    <a href="#-주요-트러블-슈팅">트러블 슈팅</a>
  </p>
</div>


---

## 👨‍💻 개발자 정보

<div align="center">

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/iyungui.png" width="150" height="150" style="border-radius: 50%;" alt="iyungui 프로필 이미지" />
    </td>
  </tr>
  <tr>
    <td align="center">
      <strong>이융의 (iyungui)</strong><br>
      iOS Developer
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://github.com/iyungui">GitHub Profile</a>
    </td>
  </tr>
</table>

</div>

## 프로젝트 개요
WDIC는 "Writing Documents In Chinese"의 약자로, 중국어 통번역 수업용 교구로 사용되기 위해 개발된 중국어 학습 앱입니다. (단어, 문장, 발음, 작문 학습 단계로 진행)


## ✨ 주요 기능

📱 스크린샷

<table>
  <tr>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/c562010f-86ef-4317-bee8-9988e19abda1" alt="시작화면" width="300">
    </td>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/f69f3611-54a2-4341-a712-6e3d8b103fb1" alt="메인화면" width="300">
    </td>
    <td align="center" width="33%">
  <img src="https://github.com/user-attachments/assets/d1740ef4-7f2f-4607-876e-ba91de7d387c" alt="메인화면" width="300">
    </td>
  </tr>
  <tr>
    <td align="center">
      <strong>시작화면</strong><br>
      <sub>이메일 로그인과 애플 로그인 지원</sub>
    </td>
    <td align="center">
      <strong>메인 화면</strong><br>
      <sub>중국어 학습 메인 화면</sub>
    </td>
    <td align="center">
      <strong>메인 화면2</strong><br>
      <sub>섹션 별로 현재 학습 이어가기 섹션과 복습하기 섹션으로 나누었습니다.</sub>
    </td>
  </tr>
</table>

**1. 단어 학습**
카드 기반 인터랙티브 학습
중국어 단어, 병음, 한국어 의미
TTS로 발음 청취
퀴즈로 학습 효과 강화

**2. 문장 연습**
맥락 기반 문장 학습
문장 구조 퀴즈
실시간 TTS

**3. 발음 훈련** 
AVFoundation 활용 TTS
녹음 및 재생 기능
단계별 발음 훈련

**작문 연습**
주제별 작문 연습
예문 참고 가이드

## 🔧 기술 스택

### iOS 클라이언트
- Swift 5.0+
- SwiftUI
- MVVM 패턴
- AVFoundation
- ACarousel (카드 슬라이더)
- Alamofire
- KeyChain
  
📐 앱 구조

```
WDIC/
├── API/
│   ├── APIEndpoint.swift          # API URL definitions
│   ├── Services/
│   │   ├── ChapterService.swift   # Chapter data fetching
│   │   ├── LessonService.swift    # Lesson content operations
│   │   ├── QuizService.swift      # Quiz data operations
│   │   └── UserService.swift      # Authentication & user data
│   └── KeyChain.swift             # Secure token storage
├── Models/
│   ├── ChapterDataModel.swift     # Chapter structure
│   ├── LessonDataModel.swift      # Lesson content models
│   ├── UserDataModel.swift        # User profile structure
│   ├── SentenceQuiz.swift         # Sentence quiz models
│   └── VocabularyQuiz.swift       # Vocabulary quiz models
├── ViewModels/
│   ├── ChapterViewModel.swift     # Chapter data management
│   ├── LessonViewModel.swift      # Lesson interaction logic
│   ├── SentenceQuizViewModel.swift # Sentence quiz logic
│   ├── SignUpViewModel.swift      # Registration logic
│   ├── UserViewModel.swift        # User profile management
│   └── VocaQuizViewModel.swift    # Vocabulary quiz logic
├── Views/
│   ├── Auth/
│   │   ├── LoginView.swift        # Main login screen
│   │   ├── EmailLoginView.swift   # Email login form
│   │   └── SignUpView.swift       # Registration flow
│   ├── Main/
│   │   ├── MainView.swift         # Tab container view
│   │   ├── HomeView.swift         # Dashboard screen
│   │   ├── ChapterView.swift      # Chapters listing
│   │   ├── CommunityView.swift    # Community forum
│   │   ├── CalendarView.swift     # Schedule view
│   │   └── ProfileView.swift      # User profile
│   ├── Lessons/
│   │   ├── Word/
│   │   │   ├── LessonWordsView.swift      # Vocabulary learning
│   │   │   └── LessonWordsQuizView.swift  # Vocabulary quiz
│   │   ├── Sentence/
│   │   │   ├── LessonSentencesView.swift     # Sentence practice
│   │   │   └── LessonSentencesQuizView.swift # Sentence quiz
│   │   ├── Pronunciation/
│   │   │   └── LessonPronView.swift       # Pronunciation practice
│   │   └── Writing/
│   │       └── LessonWriteView.swift      # Writing exercises
│   └── Components/
│       ├── CustomTabBar.swift              # Navigation tab bar
│       ├── ProgressBar.swift               # Progress indicator
│       ├── NavigationViewComponent.swift   # Navigation headers
│       └── ModalAnswerView.swift           # Quiz answer overlay
└── Utilities/
    ├── AudioRecorderPlayer.swift     # Voice recording functionality
    ├── TextToSpeechManager.swift     # TTS implementation
    ├── ImagePicker.swift             # Image selection utility
    └── KeyboardResponder.swift       # Keyboard handling
```
