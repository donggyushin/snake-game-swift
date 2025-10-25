# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Snake Game for macOS built with SwiftUI, using Tuist for project generation. The game features a classic snake gameplay with score tracking, adjustable difficulty (speed increases with snake length), and persistent high scores.

## Build and Development Commands

- `tuist generate` — Regenerate Xcode workspace when project configuration changes
- `tuist build SnakeGame` — Build the macOS app target
- `tuist test SnakeGame` — Run the test suite
- `tuist run SnakeGame` — Launch the app via CLI
- `open SnakeGame.xcodeproj` — Open in Xcode for interactive debugging

## Architecture Overview

### Layer Structure

The codebase follows a clean architecture pattern with three main layers:

1. **Domain Layer** (`SnakeGame/Sources/domain/`)
   - Entity models: `Square`, `Food`, `Direction`, `Score`
   - Repository protocols: `ScoreRepository` defines the contract for score persistence

2. **Infrastructure Layer** (`SnakeGame/Sources/infra/`)
   - Repository implementations: `ScoreRepositoryUserDefaults` (production), `ScoreRepositoryMock` (testing)
   - Property wrappers: `UserDefaultsWrapper` for persisting data

3. **Application Layer** (`SnakeGame/Sources/app/`)
   - SwiftUI views and view models
   - Dependency injection: `Container` singleton provides dependencies, `@Injected` property wrapper for injection
   - Event communication: `EventBus` singleton for cross-window events (e.g., nickname form to main view)

### Key Components

**ContentViewModel** (`ContentViewModel.swift`): Core game logic controller
- Manages snake movement, collision detection, food generation, and scoring
- Uses `@MainActor` to ensure all state mutations happen on the main thread
- Dynamic difficulty: `tickInterval` property decreases (speeds up) as snake grows
- Grid-based coordinate system: snake can move from (0,0) to (grid-1, grid-1)

**Dependency Injection Pattern**:
- `Container.swift:23-29` — Automatically switches between mock and real repositories based on environment (preview/test vs production)
- Use `@Injected(\.scoreRepository)` to inject dependencies in view models

**Multi-Window Management**:
- Main game window and separate nickname form window
- `EventBus.shared.nicknameEventForSavingRecord` communicates from nickname form to main view
- Nickname form shown when saving a new high score

### Game Mechanics

- Snake starts at center of grid (`grid / 2, grid / 2`)
- Movement: Each tick moves snake segments one grid unit in their direction
- Collision detection checks: boundary violations and self-collision
- Food spawns randomly at 1/8 chance per tick (three consecutive `Bool.random()` checks)
- Snake grows by appending a new tail segment behind the last segment when eating food
- Speed progression: 1.0s → 0.8s → 0.6s → 0.4s → 0.3s → 0.2s → 0.1s intervals at 0, 3, 6, 10, 15, 20, 30+ segments

## Testing

- Tests use Apple's Swift Testing framework (not XCTest)
- Annotate test methods with `@Test`, use `#expect(...)` for assertions
- Mock implementations automatically injected in test environment via Container
- Run full suite before commits: `tuist test SnakeGame`
