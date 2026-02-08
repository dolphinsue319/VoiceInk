## ADDED Requirements

### Requirement: Application Support directory migration
The system SHALL migrate the Application Support directory from `com.prakashjoshipax.VoiceInk` to `com.kedia.Typeless` on first launch when the old directory exists and the new directory does not.

#### Scenario: Old directory exists, new directory does not
- **WHEN** the app launches and `~/Library/Application Support/com.prakashjoshipax.VoiceInk/` exists and `~/Library/Application Support/com.kedia.Typeless/` does not exist
- **THEN** the system SHALL move the old directory to the new path, preserving all contents (SwiftData stores, Whisper models, recordings)

#### Scenario: New directory already exists
- **WHEN** the app launches and `~/Library/Application Support/com.kedia.Typeless/` already exists
- **THEN** the system SHALL NOT attempt any migration, regardless of whether the old directory exists

#### Scenario: Old directory does not exist
- **WHEN** the app launches and `~/Library/Application Support/com.prakashjoshipax.VoiceInk/` does not exist
- **THEN** the system SHALL skip migration and proceed normally (fresh install)

### Requirement: Keychain items migration
The system SHALL migrate all keychain items from the old service identifier `com.prakashjoshipax.VoiceInk` to the new service identifier `com.kedia.Typeless` on first launch.

#### Scenario: First launch with existing keychain items
- **WHEN** the app launches for the first time after rebrand and keychain items exist under the old service identifier
- **THEN** the system SHALL copy each item to the new service identifier, delete the old item, and set a `UserDefaults` flag to prevent re-migration

#### Scenario: Subsequent launches after migration
- **WHEN** the app launches and the migration flag `keychainMigrationFromOldServiceDone` is already set in `UserDefaults`
- **THEN** the system SHALL skip keychain migration entirely

#### Scenario: No old keychain items exist
- **WHEN** the app launches for the first time and no keychain items exist under the old service identifier
- **THEN** the system SHALL set the migration flag and proceed without error

### Requirement: Updated bundle identifiers
All project targets SHALL use the new bundle identifier scheme:
- App: `com.kedia.Typeless`
- Tests: `com.kedia.TypelessTests`
- UI Tests: `com.kedia.TypelessUITests`

#### Scenario: App bundle identifier
- **WHEN** the app is built
- **THEN** the product bundle identifier SHALL be `com.kedia.Typeless`

### Requirement: Updated iCloud container
The app SHALL use iCloud container `iCloud.com.kedia.Typeless` for CloudKit sync.

#### Scenario: CloudKit database reference
- **WHEN** the app initializes its SwiftData container with CloudKit sync
- **THEN** the CloudKit database identifier SHALL be `iCloud.com.kedia.Typeless`

### Requirement: Updated keychain access group
The app entitlements SHALL specify keychain access group `$(AppIdentifierPrefix)com.kedia.Typeless`.

#### Scenario: Keychain access
- **WHEN** the app reads or writes keychain items
- **THEN** the keychain service identifier SHALL be `com.kedia.Typeless`
