## Why

The project is being rebranded from the original upstream identity (`com.prakashjoshipax.VoiceInk`) to a new identity (`com.kedia.Typeless`). All bundle IDs, iCloud containers, keychain service identifiers, and Application Support directory paths must be updated to reflect the new brand. Existing users must not lose their data (SwiftData stores, Whisper models, recordings, API keys stored in Keychain) during the transition.

## What Changes

- **BREAKING**: Bundle identifier changes from `com.prakashjoshipax.VoiceInk` to `com.kedia.Typeless` across all targets (app, tests, UI tests).
- Development team changes from `V6J6A3VWY2` to `SBS3WRZTPU`.
- iCloud container changes from `iCloud.com.prakashjoshipax.VoiceInk` to `iCloud.com.kedia.Typeless`.
- Keychain access group and service identifier updated to `com.kedia.Typeless`.
- All hardcoded Application Support sub-directory references updated from `com.prakashjoshipax.VoiceInk` to `com.kedia.Typeless`.
- One-time data migration added: moves the old Application Support directory to the new path if the new path does not yet exist.
- One-time keychain migration added: copies all keychain items from the old service identifier to the new one and deletes the old entries.
- Info.plist cleaned up: keys moved from explicit plist entries to Xcode-managed `INFOPLIST_KEY_*` build settings where appropriate.

## Capabilities

### New Capabilities
- `bundle-id-migration`: One-time migration logic that moves Application Support data and Keychain items from the old `com.prakashjoshipax.VoiceInk` identifiers to the new `com.kedia.Typeless` identifiers on first launch, ensuring no data loss during rebrand.

### Modified Capabilities
<!-- No existing specs to modify -->

## Impact

- **Xcode project**: `project.pbxproj` — bundle IDs, development team, Info.plist keys across all 6 build configurations (Debug/Release × App/Tests/UITests).
- **Entitlements**: `VoiceInk.entitlements` — iCloud container ID, keychain access group.
- **Info.plist**: Restructured; some keys moved to build settings.
- **Swift source files** (5 files):
  - `VoiceInk.swift` — Application Support path + migration helper.
  - `WhisperState.swift` — Application Support path + inline migration fallback.
  - `KeychainService.swift` — service identifier + keychain migration logic.
  - `AudioFileTranscriptionManager.swift` — recordings directory path.
  - `AudioFileTranscriptionService.swift` — recordings directory path.
  - `TranscriptionAutoCleanupService.swift` — recordings directory path.
- **User data**: Existing Keychain secrets and Application Support files are migrated; no data loss expected.
- **iCloud**: CloudKit container name changes; existing synced data on the old container will not carry over automatically.
