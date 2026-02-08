## Context

The app was forked from the upstream VoiceInk project (`com.prakashjoshipax.VoiceInk`). To publish under a new brand, all Apple platform identifiers (bundle ID, iCloud container, keychain service, development team) must change. Existing users who have been running the old bundle ID locally will have data in `~/Library/Application Support/com.prakashjoshipax.VoiceInk/` and keychain items keyed to the old service name. This data must be preserved transparently.

## Goals / Non-Goals

**Goals:**
- Replace all references to the old bundle identifier with `com.kedia.Typeless`.
- Migrate Application Support directory contents from the old path to the new path on first launch.
- Migrate Keychain items from the old service identifier to the new one on first launch.
- Ensure no data loss for SwiftData stores, Whisper models, audio recordings, and API keys.

**Non-Goals:**
- Migrating iCloud CloudKit data from the old container (requires Apple-side container transfer, out of scope).
- Renaming the Xcode project or source directory from `VoiceInk` to `Typeless` (cosmetic, deferred).
- Updating Sparkle update feed URL or public key (separate concern).

## Decisions

1. **Move-based Application Support migration**: Use `FileManager.moveItem(at:to:)` to relocate the entire old directory to the new path. This is atomic on the same volume, avoids doubling disk usage, and is a single operation.
   - *Alternative*: Copy + delete — slower, uses 2× disk during migration, more error-prone.
   - *Alternative*: Symlink — fragile, breaks if user deletes old directory.

2. **Guard: only migrate if new path doesn't exist**: Prevents re-migration or overwriting if the user has already run the new version. The check `!fm.fileExists(atPath: newURL.path)` is the gate.

3. **Keychain migration via query-all + re-save + delete**: Enumerate all items under the old service, save each to the new service, then delete the old entry. Uses a `UserDefaults` boolean flag (`keychainMigrationFromOldServiceDone`) to ensure one-time execution.
   - *Alternative*: Leave old keychain items and read from both — adds permanent complexity to every keychain read.

4. **Duplicate migration call sites**: Both `VoiceInkApp.createPersistentContainer` and `WhisperState.init` attempt the Application Support directory migration independently. This provides resilience — whichever code path executes first performs the migration, and the guard prevents double-move.

## Risks / Trade-offs

- **[Risk] iCloud data not migrated** → Users lose synced dictionary data. Mitigation: Documented as non-goal; iCloud container transfer requires manual Apple Developer Portal action.
- **[Risk] Partial keychain migration on error** → The `UserDefaults` flag is set in `defer`, so even partial migration won't retry. Mitigation: Each item is migrated independently; failure on one item doesn't block others.
- **[Risk] Race condition on duplicate migration sites** → Two code paths check `fileExists` and call `moveItem`. Mitigation: `moveItem` will fail if source no longer exists; the error is caught silently (`try?`).
