📱 Offline-First Flutter Architecture (Hive + Bloc + Background Sync)

A production-grade offline-first Flutter application demonstrating how large teams design, implement, and test reliable data synchronization using clean architecture principles.

This project is intentionally architecture-focused, not UI-heavy.

✨ Key Highlights

✅ Offline-first by design (local DB is source of truth)

✅ Hive for fast local persistence

✅ Bloc for predictable state management

✅ Clean Architecture (presentation / domain / data)

✅ Background sync (Isolate + WorkManager)

✅ Conflict resolution (version + updatedAt)

✅ Soft deletes

✅ Unit & integration tests

✅ Testable sync logic (no platform dependencies)

🧠 Offline-First Philosophy

The UI never talks to the network.

UI → Bloc → Repository → Hive (truth)
                         ↓
                   Sync Engine
                         ↓
                       API


The app works fully offline

Network is used only for synchronization

No “if internet then API” logic

UI always reflects local database state

🏗️ Architecture Overview
lib/
├── core/
│   ├── sync/                 # Sync engine & services
│   ├── network/              # API client
│   ├── background/           # WorkManager tasks
│   └── di/                   # Dependency injection
│
├── features/
│   └── users/
│       ├── presentation/     # UI + Bloc
│       ├── domain/            # Entities & contracts
│       └── data/              # Local + Remote data sources
│
└── main.dart

Design Rules

UI imports domain only

Sync logic lives in core

Platform plugins are wrapped & isolated

lib/ never depends on test/

📦 Tech Stack
Concern	Technology
State management	flutter_bloc
Local database	hive
Background sync	Isolate, workmanager
Networking	dio
Dependency injection	get_it
Testing	flutter_test, mocktail, hive_test, bloc_test
🔄 Synchronization Flow
Push (Local → Server)

Detect unsynced records

Upload to server

Increment version

Mark as synced

Pull (Server → Local)

Fetch server records

Resolve conflicts

Upsert locally

Conflict Resolution Strategy

Last-write-wins

Version based

Timestamp fallback

Soft delete wins over update

🧩 Key Components
UserSyncService

Pure sync logic:

No isolates

No connectivity checks

Fully unit testable

Used by:

UI-triggered sync

Background sync

Integration tests

SyncManager

Execution strategy:

Connectivity check

Runs sync in isolate

Orchestrates background execution

UserRemoteContract

Abstraction over remote API:

Real API implementation (Dio)

Fake in-memory implementation for tests

🧪 Testing Strategy
Unit Tests

Domain entities

Repositories

Sync logic

Bloc state transitions

Integration Tests

Real Hive database

Offline → Online sync flow

Conflict resolution scenarios

Isolates and platform plugins are not tested directly
Business logic is tested deterministically

▶️ Getting Started
1️⃣ Install dependencies
flutter pub get

2️⃣ Generate Hive adapters
flutter pub run build_runner build --delete-conflicting-outputs

3️⃣ Run the app
flutter run

4️⃣ Run tests
flutter test

🧪 Test Structure
test/
├── core/
│   └── sync/
├── features/
│   └── users/
├── integration/
└── fakes/


Fakes live in test/fakes

No test code leaks into lib

🚀 Why This Project Exists

This project is not a tutorial toy.

It exists to demonstrate:

How real apps handle offline data

How to keep sync logic testable

How large teams separate concerns

How to avoid flaky background behavior

How to pass architecture reviews

🧭 Future Improvements

⏱ Retry & exponential backoff

🧾 Sync failure analytics

🧹 Tombstone cleanup

🔐 Encrypted Hive boxes

🧪 CI pipeline (GitHub Actions)

📊 Sync metrics & logs

🧑‍💻 Ideal For

Senior Flutter developers

Offline-first applications

Interview preparation

Architecture reference

Production scaffolding

📜 License

This project is provided for learning and reference purposes.
Use freely, adapt responsibly.
