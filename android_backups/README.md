# Android Configuration Backups

This folder contains backup copies of Android configuration files that were modified during the Flutter local notifications implementation.

## Backup Information

**Backup Date**: 2025-11-27  
**Purpose**: Preserve original Android configuration before adding local notification support

## Backed Up Files

The following files have been backed up with their original folder structure:

- `app/src/main/AndroidManifest.xml` - Main Android manifest file (original backup)
- `app/build.gradle.kts` - App-level Gradle build configuration (original backup)
- `app/build.gradle.kts.backup2` - Second backup after core library desugaring changes
- `settings.gradle.kts` - Project-level Gradle settings (backup before AGP version update)

## How to Restore Backup Files

If you need to revert the Android configuration changes and restore the original files, follow these steps:

### Option 1: Manual Restore (Recommended)

1. **Backup Current Files** (optional, if you want to preserve the modified versions):
   ```powershell
   # Navigate to project root
   cd d:\Users\Sarang\Documents\Flutter_Projects\todo_app
   
   # Create a temporary backup of current files
   Copy-Item "android\app\src\main\AndroidManifest.xml" -Destination "AndroidManifest.xml.modified"
   Copy-Item "android\app\build.gradle.kts" -Destination "build.gradle.kts.modified"
   ```

2. **Restore AndroidManifest.xml**:
   ```powershell
   Copy-Item "android_backups\app\src\main\AndroidManifest.xml" -Destination "android\app\src\main\AndroidManifest.xml" -Force
   ```

3. **Restore build.gradle.kts** (if modified):
   ```powershell
   Copy-Item "android_backups\app\build.gradle.kts" -Destination "android\app\build.gradle.kts" -Force
   ```

4. **Clean and rebuild the project**:
   ```powershell
   flutter clean
   flutter pub get
   flutter run
   ```

### Option 2: Using PowerShell Script

You can create a restore script for quick restoration:

1. Create a file named `restore_android_backups.ps1` in the project root with this content:

```powershell
# Restore Android configuration backups
Write-Host "Restoring Android configuration files from backups..." -ForegroundColor Yellow

# Restore AndroidManifest.xml
Copy-Item "android_backups\app\src\main\AndroidManifest.xml" -Destination "android\app\src\main\AndroidManifest.xml" -Force
Write-Host "✓ Restored AndroidManifest.xml" -ForegroundColor Green

# Restore build.gradle.kts (if exists)
if (Test-Path "android_backups\app\build.gradle.kts") {
    Copy-Item "android_backups\app\build.gradle.kts" -Destination "android\app\build.gradle.kts" -Force
    Write-Host "✓ Restored build.gradle.kts" -ForegroundColor Green
}

Write-Host "`nBackup restoration complete!" -ForegroundColor Green
Write-Host "Run 'flutter clean && flutter pub get' to rebuild the project." -ForegroundColor Cyan
```

2. Run the script from the project root:
   ```powershell
   .\restore_android_backups.ps1
   ```

### Option 3: Git Restore (if using version control)

If you committed the original files to Git before modifications:

```powershell
# Restore specific files from the last commit
git checkout HEAD -- android/app/src/main/AndroidManifest.xml
git checkout HEAD -- android/app/build.gradle.kts

# Or restore from a specific commit
git checkout <commit-hash> -- android/app/src/main/AndroidManifest.xml
```

## After Restoring

After restoring the backup files:

1. **Remove notification dependencies** from `pubspec.yaml` if you want to completely remove notifications:
   ```yaml
   # Remove this line:
   flutter_local_notifications: ^x.x.x
   ```

2. **Clean the project**:
   ```powershell
   flutter clean
   flutter pub get
   ```

3. **Delete notification service** (if created):
   - Remove `lib/app/utils/notification_service.dart`
   - Remove any notification initialization code from `lib/main.dart`

4. **Rebuild and run**:
   ```powershell
   flutter run
   ```

## Important Notes

> [!WARNING]
> Restoring these files will remove all local notification functionality from the app. Make sure this is what you want before proceeding.

> [!TIP]
> Keep this backup folder in your project even after successful implementation. It serves as a reference point if you need to troubleshoot or understand what changed.

> [!NOTE]
> These backups do not include any Dart/Flutter code changes, only Android native configuration files. If you need to restore Dart code, use Git version control.

## Backup File Structure

```
android_backups/
├── README.md (this file)
└── app/
    ├── src/
    │   └── main/
    │       └── AndroidManifest.xml
    └── build.gradle.kts
```

## Questions or Issues?

If you encounter any issues while restoring backups:

1. Verify that the backup files exist and are not corrupted
2. Check file permissions
3. Ensure you're running commands from the project root directory
4. Try cleaning the Flutter build cache: `flutter clean`
5. If all else fails, you can manually copy the content from backup files to the original locations using a text editor
