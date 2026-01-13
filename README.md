# Kick - 5초 웃긴 영상 플랫폼 🎯

"5초 안에 웃기거나, 사라지거나"

Kick은 5초 이내의 웃긴 영상만 공유하는 숏폼 비디오 플랫폼입니다.

## 핵심 기능 ✨

- **5초 자동 제한**: 5.0초가 되면 자동으로 녹화 종료
- **인앱 촬영 전용**: 갤러리 업로드 불가, 오직 앱 내 카메라로만 촬영
- **자동 압축**: 업로드 전 720p/1Mbps로 자동 압축 (~600KB)
- **Kick 시스템**: 재미있는 영상에 "Kick" 👊 (좋아요 개념)
- **무한 스크롤**: 세로 스와이프로 다음 영상 시청
- **안전장치**: 3회 신고 시 자동 삭제

## 기술 스택 🛠

- **Frontend**: Flutter
- **Backend**: Firebase (Storage, Firestore)
- **영상 처리**: video_compress
- **카메라**: camera plugin

## 설치 방법 📦

### 1. 의존성 설치

```bash
flutter pub get
```

### 2. Firebase 설정

자세한 Firebase 설정은 [FIREBASE_SETUP.md](FIREBASE_SETUP.md)를 참고하세요.

간단 요약:
1. [Firebase Console](https://console.firebase.google.com/)에서 프로젝트 생성
2. Android 앱 추가 (`com.kick.app`)
3. `google-services.json` 파일을 `android/app/` 에 복사
4. iOS 앱 추가 (`com.kick.app`)
5. `GoogleService-Info.plist` 파일을 `ios/Runner/` 에 추가
6. Firebase Storage 및 Firestore 활성화

### 3. 앱 실행

```bash
# Android
flutter run

# iOS
flutter run -d ios

# 특정 디바이스
flutter devices
flutter run -d <device-id>
```

## 프로젝트 구조 📁

```
lib/
├── main.dart                  # 앱 진입점
├── models/
│   └── video_model.dart       # 영상 데이터 모델
├── screens/
│   ├── home_screen.dart       # 메인 피드 화면
│   └── camera_screen.dart     # 5초 촬영 화면
├── services/
│   ├── firebase_service.dart  # Firebase 관련 서비스
│   └── video_service.dart     # 영상 압축 서비스
└── widgets/
    ├── video_player_widget.dart  # 영상 재생 위젯
    └── kick_button.dart          # Kick 버튼 위젯
```

## 사용 방법 📱

### 영상 시청
1. 앱 실행 시 자동으로 영상 재생
2. 위로 스와이프하여 다음 영상 보기
3. 👊 Kick 버튼으로 재미있는 영상에 반응

### 영상 촬영
1. 하단 📹 버튼 클릭
2. 카메라가 실행되면 녹화 버튼 누르기
3. 5초 자동 녹화 후 자동 압축 및 업로드

### 신고하기
1. 우측 상단 🚩 깃발 아이콘 클릭
2. 신고 확인
3. 3회 누적 시 자동 삭제

## Phase 1 구현 완료 ✅

- [x] 인앱 5초 촬영
- [x] 클라이언트 압축
- [x] Firebase 업로드
- [x] 무한 스크롤 재생
- [x] Kick 버튼 기능
- [x] 신고 시스템

## 다음 단계 (Phase 2 & 3) 🚀

- [ ] Google Vision API 연동 (AI 필터링)
- [ ] 일일 랭킹 시스템
- [ ] 리워드 포인트 시스템
- [ ] 사용자 인증 (Firebase Auth)
- [ ] 프로필 페이지
- [ ] 광고 시스템

## 개발 환경

- Flutter: 3.9.2 이상
- Dart: 3.0 이상
- Android: API 21 이상
- iOS: iOS 12 이상

## 라이선스

이 프로젝트는 상업적 목적으로 사용 가능합니다.
