#!/usr/bin/env bash
# Offline smoke tests for profile selection. No Android device required.
set -e
source "$(dirname "$0")/../functions/helper.sh"
cecho() { printf '%s\n' "$*"; }
adb() {
  case "$*" in
    "shell pm list users")
      printf 'Users:\n\tUserInfo{0:Owner:13} running\n\tUserInfo{10:Work profile:30} running\n'
      ;;
    *) echo "unexpected adb call: $*" >&2; return 1 ;;
  esac
}
whiptail() { printf '10'; }
unset android_user
select_android_profile
test "$android_user" = "10"
android_user=0
select_android_profile
test "$android_user" = "0"
android_user=23
if select_android_profile; then
  echo "unavailable profile was accepted" >&2
  exit 1
fi
android_user="10;rm -rf /"
if select_android_profile; then
  echo "invalid profile was accepted" >&2
  exit 1
fi
echo "Profile selection smoke tests passed"
