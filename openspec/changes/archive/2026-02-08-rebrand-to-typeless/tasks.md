## 1. Xcode Project Configuration

- [ ] 1.1 Update `PRODUCT_BUNDLE_IDENTIFIER` to `com.kedia.Typeless` in Debug and Release build configurations for the app target
- [ ] 1.2 Update `PRODUCT_BUNDLE_IDENTIFIER` to `com.kedia.TypelessTests` for test targets (Debug/Release)
- [ ] 1.3 Update `PRODUCT_BUNDLE_IDENTIFIER` to `com.kedia.TypelessUITests` for UI test targets (Debug/Release)
- [ ] 1.4 Update `DEVELOPMENT_TEAM` from `V6J6A3VWY2` to `SBS3WRZTPU` across all targets and configurations
- [ ] 1.5 Move `NSMicrophoneUsageDescription`, `NSAppleEventsUsageDescription`, and `LSUIElement` from Info.plist to `INFOPLIST_KEY_*` build settings

## 2. Entitlements & Info.plist

- [ ] 2.1 Update iCloud container identifier to `iCloud.com.kedia.Typeless` in `VoiceInk.entitlements`
- [ ] 2.2 Update keychain access group to `$(AppIdentifierPrefix)com.kedia.Typeless` in `VoiceInk.entitlements`
- [ ] 2.3 Clean up Info.plist: remove keys now handled by build settings, reorder remaining keys alphabetically

## 3. Application Support Path Updates

- [ ] 3.1 Update hardcoded path in `VoiceInk.swift` (`createPersistentContainer`) from `com.prakashjoshipax.VoiceInk` to `com.kedia.Typeless`
- [ ] 3.2 Update hardcoded path in `WhisperState.swift` from `com.prakashjoshipax.VoiceInk` to `com.kedia.Typeless`
- [ ] 3.3 Update hardcoded path in `AudioFileTranscriptionManager.swift` from `com.prakashjoshipax.VoiceInk` to `com.kedia.Typeless`
- [ ] 3.4 Update hardcoded path in `AudioFileTranscriptionService.swift` from `com.prakashjoshipax.VoiceInk` to `com.kedia.Typeless`
- [ ] 3.5 Update hardcoded path in `TranscriptionAutoCleanupService.swift` from `com.prakashjoshipax.VoiceInk` to `com.kedia.Typeless`

## 4. Data Migration Logic

- [ ] 4.1 Add `migrateAppSupportIfNeeded(to:logger:)` static method in `VoiceInkApp` to move old Application Support directory to new path
- [ ] 4.2 Call migration method in `createPersistentContainer` before directory creation
- [ ] 4.3 Add inline migration fallback in `WhisperState.init` for resilience
- [ ] 4.4 Update `KeychainService` service identifier to `com.kedia.Typeless`
- [ ] 4.5 Add `migrateFromOldServiceIfNeeded()` method in `KeychainService` to enumerate and migrate all keychain items from old service, gated by UserDefaults flag
- [ ] 4.6 Call keychain migration in `KeychainService.init()`

## 5. iCloud / CloudKit

- [ ] 5.1 Update CloudKit database identifier in `VoiceInk.swift` dictionary store configuration to `iCloud.com.kedia.Typeless`
