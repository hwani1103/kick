# Firebase 설정 가이드

## 1. Firebase 프로젝트 생성

1. [Firebase Console](https://console.firebase.google.com/)에 접속
2. "프로젝트 추가" 클릭
3. 프로젝트 이름: "Kick" 입력
4. Google Analytics 설정 (선택사항)

## 2. Android 설정

### 2.1 Firebase에 Android 앱 추가
1. Firebase Console에서 Android 아이콘 클릭
2. Android 패키지 이름: `com.kick.app` 입력
3. 앱 닉네임: "Kick Android" 입력
4. `google-services.json` 파일 다운로드
5. 다운로드한 파일을 `android/app/` 폴더에 복사

### 2.2 Android 설정 파일 수정

`android/build.gradle` 파일에 추가:
```gradle
buildscript {
    dependencies {
        // ...
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

`android/app/build.gradle` 파일 마지막에 추가:
```gradle
apply plugin: 'com.google.gms.google-services'
```

## 3. iOS 설정

### 3.1 Firebase에 iOS 앱 추가
1. Firebase Console에서 iOS 아이콘 클릭
2. iOS 번들 ID: `com.kick.app` 입력
3. 앱 닉네임: "Kick iOS" 입력
4. `GoogleService-Info.plist` 파일 다운로드
5. Xcode에서 `ios/Runner/` 폴더에 파일 추가

## 4. Firebase Storage 설정

1. Firebase Console에서 "Storage" 선택
2. "시작하기" 클릭
3. 보안 규칙 설정:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /videos/{videoId} {
      allow read: if true;
      allow write: if request.auth != null &&
                      request.resource.size < 5 * 1024 * 1024; // 5MB 제한
    }
  }
}
```

## 5. Cloud Firestore 설정

1. Firebase Console에서 "Firestore Database" 선택
2. "데이터베이스 만들기" 클릭
3. 보안 규칙 설정:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /videos/{videoId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update: if request.auth != null;
      allow delete: if request.auth != null ||
                       resource.data.reportCount >= 3;
    }
  }
}
```

## 6. 인덱스 설정

Firestore Console에서 복합 인덱스 생성:
- 컬렉션: `videos`
- 필드: `kicks` (내림차순), `createdAt` (내림차순)

## 7. 완료

설정이 완료되면 다음 명령어로 앱을 실행:

```bash
flutter pub get
flutter run
```
