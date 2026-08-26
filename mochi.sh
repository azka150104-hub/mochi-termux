#!/data/data/com.termux/files/usr/bin/bash
# MOCHI — launcher Roblox aman untuk Termux.
# Hanya membuka halaman resmi Roblox; tidak mengakses cookie, akun, atau root.

set -u

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mochi"
CONFIG_FILE="$CONFIG_DIR/config"
SAVED_URL="${MOCHI_GAME_URL:-}"

load_config() {
  if [ -r "$CONFIG_FILE" ]; then
    # File ini dibuat oleh MOCHI sendiri dan hanya menyimpan satu URL game.
    SAVED_URL=$(sed -n 's/^MOCHI_GAME_URL=//p' "$CONFIG_FILE" | head -n 1)
  fi
}

save_url() {
  mkdir -p "$CONFIG_DIR"
  printf 'MOCHI_GAME_URL=%s\n' "$1" > "$CONFIG_FILE"
  SAVED_URL="$1"
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

pause() {
  printf '\nTekan Enter untuk kembali ke menu...'
  IFS= read -r _
}

banner() {
  printf '\033[2J\033[H'
  printf '\n\033[1;35m'
  printf '███╗   ███╗ ██████╗  ██████╗██╗  ██╗██╗\n'
  printf '████╗ ████║██╔═══██╗██╔════╝██║  ██║██║\n'
  printf '██╔████╔██║██║   ██║██║     ███████║██║\n'
  printf '██║╚██╔╝██║██║   ██║██║     ██╔══██║██║\n'
  printf '██║ ╚═╝ ██║╚██████╔╝╚██████╗██║  ██║██║\n'
  printf '╚═╝     ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚═╝\n'
  printf '\033[0m'
  printf '                 Termux Roblox Launcher\n\n'
  printf 'Status : \033[1;32maman — tanpa cookie, root, atau akun\033[0m\n'
  if [ -n "$SAVED_URL" ]; then
    printf 'Game   : %s\n' "$SAVED_URL"
  else
    printf 'Game   : belum diatur\n'
  fi
  printf '%s\n' '----------------------------------------'
}

set_game_url() {
  printf 'Masukkan URL game Roblox resmi:\n> '
  IFS= read -r game_url
  if is_roblox_url "$game_url"; then
    save_url "$game_url"
    printf '\nURL game berhasil disimpan.\n'
  else
    printf '\nURL tidak valid. Gunakan contoh: https://www.roblox.com/games/PLACE_ID\n'
  fi
  pause
}

open_game() {
  if [ -z "$SAVED_URL" ]; then
    printf 'Belum ada URL game yang tersimpan.\n\n'
    set_game_url
    return
  fi
  printf 'Membuka game di aplikasi/browser Roblox...\n'
  open_url "$SAVED_URL"
  printf 'Silakan masuk dan bergabung secara manual.\n'
  pause
}

show_config() {
  printf 'Lokasi konfigurasi: %s\n' "$CONFIG_FILE"
  if [ -n "$SAVED_URL" ]; then
    printf 'URL game tersimpan: %s\n' "$SAVED_URL"
  else
    printf 'Belum ada URL game tersimpan.\n'
  fi
  pause
}

check_tools() {
  if command -v termux-open-url >/dev/null 2>&1; then
    printf 'termux-open-url : siap\n'
  else
    printf 'termux-open-url : belum ditemukan (jalankan: pkg install termux-tools)\n'
  fi
  if command -v git >/dev/null 2>&1; then
    printf 'git             : siap\n'
  else
    printf 'git             : belum ditemukan (jalankan: pkg install git)\n'
  fi
  pause
}

show_help() {
  printf '1. Simpan URL game Roblox resmi melalui menu 2.\n'
  printf '2. Pilih menu 1 untuk membukanya di aplikasi atau browser.\n'
  printf 'MOCHI tidak menyimpan sandi, cookie, token, atau data akun.\n'
  pause
}

load_config

if [ "$#" -gt 0 ]; then
  if is_roblox_url "$1"; then
    open_url "$1"
    exit 0
  fi
  printf 'URL tidak valid. Gunakan URL game Roblox resmi.\n' >&2
  exit 2
fi

while :; do
  banner
  printf '1.  Buka Game Roblox\n'
  printf '2.  Set URL Game\n'
  printf '3.  Lihat Konfigurasi\n'
  printf '4.  Periksa Dependensi\n'
  printf '5.  Buka Roblox Home\n'
  printf '6.  Cara Menggunakan\n'
  printf '7.  Status Privasi\n'
  printf '8.  Tampilkan URL Game\n'
  printf '9.  Buka Dokumentasi GitHub\n'
  printf '10. Tentang MOCHI\n'
  printf '11. Bantuan Termux\n'
  printf '12. Muat Ulang Konfigurasi\n'
  printf '0.  Keluar\n'
  printf '%s\n' '----------------------------------------'
  printf '> Pilih: '
  IFS= read -r choice

  case "$choice" in
    1) open_game ;;
    2) set_game_url ;;
    3) show_config ;;
    4) check_tools ;;
    5) open_url 'https://www.roblox.com/home'; printf 'Membuka Roblox Home...\n'; pause ;;
    6) show_help ;;
    7) printf 'MOCHI tidak memakai root, cookie, token, maupun data akun.\n'; pause ;;
    8) show_config ;;
    9) open_url 'https://github.com/azka150104-hub/mochi-termux'; printf 'Membuka dokumentasi GitHub...\n'; pause ;;
    10) printf 'MOCHI v1.0 — launcher game Roblox aman untuk Termux.\n'; pause ;;
    11) printf 'Pasang kebutuhan dengan: pkg install git termux-tools\n'; pause ;;
    12) load_config; printf 'Konfigurasi dimuat ulang.\n'; pause ;;
    0) printf '\nSampai jumpa.\n'; exit 0 ;;
    *) printf '\nPilihan tidak tersedia.\n'; pause ;;
  esac
done
