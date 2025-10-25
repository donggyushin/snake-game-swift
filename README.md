# Snake Game (macOS)

SwiftUI로 구현한 클래식 스네이크 게임입니다. macOS 전용으로 개발되었으며, 점수 기록 저장 기능과 난이도 자동 조절 시스템을 포함하고 있습니다.

## 주요 기능

- **클래식 스네이크 게임플레이**: 화살표 키로 뱀을 조작하여 먹이를 먹고 성장
- **동적 난이도 조절**: 뱀의 길이가 증가할수록 게임 속도가 빨라짐
- **점수 기록 시스템**: 게임 종료 후 닉네임과 함께 점수 저장
- **기록 관리**: 저장된 점수 목록 확인 및 삭제 기능
- **그리드 기반 렌더링**: Canvas API를 활용한 부드러운 그래픽

## 기술 스택

- **언어**: Swift
- **프레임워크**: SwiftUI
- **빌드 도구**: Tuist
- **아키텍처**: Clean Architecture (Domain, Infrastructure, Application layers)
- **의존성 주입**: 커스텀 DI 컨테이너
- **데이터 저장**: UserDefaults (Property Wrapper 패턴)

## 요구사항

- macOS 14.0 이상
- Xcode 15.0 이상
- Tuist (프로젝트 관리)

## 설치 및 실행

1. 저장소 클론
```bash
git clone <repository-url>
cd snake-game-swift
```

2. Tuist로 프로젝트 생성
```bash
tuist generate
```

3. 빌드 및 실행
```bash
# CLI로 실행
tuist run SnakeGame

# 또는 Xcode에서 실행
open SnakeGame.xcodeproj
```

## 게임 방법

- **방향키 (↑ ↓ ← →)**: 뱀의 이동 방향 조절
- **목표**: 노란색 먹이를 먹어서 뱀을 성장시키기
- **게임 오버**: 벽이나 자기 몸에 부딪히면 게임 종료
- **점수**: 뱀의 길이 × 10점

### 속도 변화

뱀의 길이에 따라 이동 속도가 점차 빨라집니다:
- 0~2칸: 1.0초/칸
- 3~5칸: 0.8초/칸
- 6~9칸: 0.6초/칸
- 10~14칸: 0.4초/칸
- 15~19칸: 0.3초/칸
- 20~29칸: 0.2초/칸
- 30칸 이상: 0.1초/칸

## 프로젝트 구조

```
SnakeGame/
├── Sources/
│   ├── domain/          # 도메인 레이어
│   │   ├── entity/      # 게임 엔티티 (Square, Food, Direction, Score)
│   │   └── repository/  # 저장소 프로토콜
│   ├── infra/           # 인프라 레이어
│   │   ├── repository/  # 저장소 구현체
│   │   └── propertyWrapper/  # 유틸리티
│   └── app/             # 애플리케이션 레이어
│       ├── container/   # 의존성 주입
│       ├── ContentView.swift       # 메인 게임 화면
│       ├── ContentViewModel.swift  # 게임 로직
│       ├── LeftSideBar.swift      # 점수판 UI
│       └── EventBus.swift         # 이벤트 통신
└── Tests/
    └── SnakeGameTests.swift
```

## 개발

### 테스트 실행

```bash
tuist test SnakeGame
```

### 프로젝트 재생성 (설정 변경 시)

```bash
tuist generate
```

### 아키텍처 특징

- **Clean Architecture**: 도메인, 인프라, 애플리케이션 레이어 분리
- **의존성 주입**: `@Injected` 프로퍼티 래퍼를 통한 자동 주입
- **환경별 구현체 자동 전환**: 테스트/프리뷰 환경에서는 Mock, 프로덕션에서는 UserDefaults 사용
- **@MainActor 격리**: SwiftUI 상태 변경의 스레드 안전성 보장

## 라이센스

MIT License
