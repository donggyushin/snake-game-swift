# Repository Guidelines

## Project Structure & Module Organization
- Application sources live in `SnakeGame/Sources`, split into SwiftUI views, view models, and game models. Keep new UI elements under `Views`/`ViewModels` subfolders if added.
- Shared assets (colors, sounds, etc.) belong in `SnakeGame/Resources`.
- Unit and async tests reside in `SnakeGame/Tests`, currently organized by feature in `SnakeGameTests.swift`.
- Project configuration is driven by `Project.swift` (Tuist) at the repo root. Update it whenever you add targets, resources, or external packages.

## Build, Test, and Development Commands
- `tuist generate` — regenerate the Xcode workspace when the project description changes.
- `tuist build SnakeGame` — compile the macOS app target locally.
- `tuist test SnakeGame` — execute the test bundle using Tuist’s XCTest runner.
- `tuist run SnakeGame` or `open SnakeGame.xcodeproj` — launch the app either via CLI or Xcode for interactive debugging.

## Coding Style & Naming Conventions
- Use Swift’s default style: four-space indentation, trailing commas where Xcode adds them, and `UpperCamelCase` for types, `lowerCamelCase` for variables/functions.
- Prefer `@MainActor` for state mutations tied to SwiftUI rendering, mirroring the existing `ContentViewModel`.
- Keep view-models source-of-truth for game state; views should trigger async tasks instead of mutating `@Published` properties directly.
- Before committing, run `swift format` (Xcode’s “Editor > Format”) or your preferred formatter to keep diffs clean.

## Testing Guidelines
- Tests use Apple’s new `Testing` package. Annotate methods with `@Test` and assert via `#expect(...)`.
- Name test files `<Feature>Tests.swift` and keep async/actor isolation explicit (`async throws`).
- Run `tuist test SnakeGame` before raising a PR; aim to cover direction changes, collision checks, and timing logic when modifying game rules.

## Commit & Pull Request Guidelines
- Commit messages should be short, imperative summaries (e.g., `view: adjust timeline loop`). Avoid generic `fix` messages.
- Each PR should describe behavioural changes, testing performed (`tuist test SnakeGame` or manual steps), and include screenshots/GIFs when UI updates affect visuals.
- Cross-reference Jira/Ticket IDs or GitHub issues in the PR body when applicable, and request review from a teammate familiar with the affected module.
