# Android profile selection

The wizard calls `adb shell pm list users` and offers the available profiles. The selected numeric ID is stored in `android_user`. For unattended usage, set `android_user=0` (or another available numeric ID) before sourcing `backup.sh`. With one user the wizard selects it automatically.

Profile IDs are used for `pm list packages`, `pm path`, package installation, companion app launch/grants, and `/storage/emulated/<user>` paths. The backup archive includes `android_user` in its settings.

**Limitation:** stock Android often blocks ADB from reading work-profile package information and emulated storage even when `pm list users` can see the profile. This patch does not bypass Android profile isolation, device policy, or work-profile encryption. Profile selection is therefore experimental; access-denied errors should be expected on managed profiles. A successful APK export never includes private app data.

The size estimate is best-effort: permission-restricted directories and content providers may be omitted. Verify backup contents independently. Before restoring, ensure the selected Android user is the intended destination.

Manual checks: `bash -n backup.sh functions/*.sh`; run wizard with a device with personal and work profiles; verify that the selected ID propagates to all Android commands and that denied storage access returns failure rather than success.
