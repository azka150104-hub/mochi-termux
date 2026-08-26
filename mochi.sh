#!/data/data/com.termux/files/usr/bin/bash
# MOCHI — launcher Roblox aman untuk Termux.
# Membuka halaman game di aplikasi/browser; tidak mengakses cookie, akun, atau root.

set -eu

DEFAULT_URL="${MOCHI_GAME_URL:-}"

banner() {
  printf '\n\033[1;35m'
  printf '███╗   ███╗ ██████╗  ██████╗██╗  ██╗██╗\n'
  printf '████╗ ████║██╔═══██╗██╔════╝██║  ██║██║\n'
  printf '██╔████╔██║██║   ██║██║     ███████║██║\n'
  printf '██║╚██╔╝██║██║   ██║██║     ██╔══██║██║\n'
  printf '██║ ╚═╝ ██║╚██████╔╝╚██████╗██║  ██║██║\n'
  printf '╚═╝     ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚═╝\n'
  printf '\033[0m'
  printf 'Roblox game launcher for Termux (manual sign-in & joining)\n\n'
}

is_roblox_url() {
  case "$1" in
    https://www.roblox.com/games/*|https://web.roblox.com/games/*) return 0 ;;
    *) return 1 ;;
  esac
}

open_url() {
  if command -v termux-open-url >/dev/null 2>&1; then
    termux-open-url "$1"
  elif command -v am >/dev/null 2>&1; then
    am start -a android.intent.action.VIEW -d "$1" >/dev/null
  else
    printf 'Tidak menemukan termux-open-url atau Android Activity Manager.\n' >&2
    return 1
  fi
}

banner
URL="${1:-$DEFAULT_URL}"

if [ -z "$URL" ]; then
  printf 'Masukkan URL game Roblox (contoh: https://www.roblox.com/games/PLACE_ID):\n> '
  IFS= read -r URL
fi

if ! is_roblox_url "$URL"; then
  printf '\nURL tidak valid. Gunakan tautan game resmi, misalnya https://www.roblox.com/games/PLACE_ID\n' >&2
  exit 2
fi

printf '\nMembuka game di aplikasi/browser Roblox...\n'
open_url "$URL"
printf 'Silakan masuk dan bergabung secara manual. MOCHI tidak menyimpan cookie, sandi, atau token.\n'
