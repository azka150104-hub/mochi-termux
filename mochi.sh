#!/data/data/com.termux/files/usr/bin/bash
# MOCHI — launcher Roblox aman untuk Termux.
# Menerima Place ID angka dan membuka halaman game resmi Roblox.

set -u

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mochi"
CONFIG_FILE="$CONFIG_DIR/config"
SAVED_PLACE_ID="${MOCHI_PLACE_ID:-}"

load_config() {
  if [ -r "$CONFIG_FILE" ]; then
    # Dibuat oleh MOCHI: hanya satu Place ID angka, tanpa akun atau cookie.
    SAVED_PLACE_ID=$(sed -n 's/^MOCHI_PLACE_ID=//p' "$CONFIG_FILE" | head -n 1)
  fi
}

save_place_id() {
  mkdir -p "$CONFIG_DIR"
  printf 'MOCHI_PLACE_ID=%s\n' "$1" > "$CONFIG_FILE"
  SAVED_PLACE_ID="$1"
}

is_place_id() {
  case "$1" in
    ''|*[!0-9]*) return 1 ;;
    *) return 0 ;;
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

open_game_by_id() {
  open_url "https://www.roblox.com/games/$1"
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
  printf 'Status   : \033[1;32maman — tanpa cookie, root, atau akun\033[0m\n'
  if [ -n "$SAVED_PLACE_ID" ]; then
    printf 'Place ID : %s\n' "$SAVED_PLACE_ID"
  else
    printf 'Place ID : belum diatur\n'
  fi
  printf '%s\n' '----------------------------------------'
}

set_place_id() {
  printf 'Masukkan Place ID game Roblox (angka saja):\n> '
  IFS= read -r place_id
  if is_place_id "$place_id"; then
    save_place_id "$place_id"
    printf '\nPlace ID berhasil disimpan.\n'
  else
    printf '\nPlace ID tidak valid. Masukkan angka saja.\n'
  fi
  pause
}

open_game() {
  if [ -z "$SAVED_PLACE_ID" ]; then
    printf 'Belum ada Place ID tersimpan.\n\n'
    set_place_id
    return
  fi
  printf 'Membuka game di aplikasi/browser Roblox...\n'
  open_game_by_id "$SAVED_PLACE_ID"
  printf 'Silakan masuk dan bergabung secara manual.\n'
  pause
}

show_config() {
  printf 'Lokasi konfigurasi: %s\n' "$CONFIG_FILE"
  if [ -n "$SAVED_PLACE_ID" ]; then
    printf 'Place ID tersimpan: %s\n' "$SAVED_PLACE_ID"
  else
    printf 'Belum ada Place ID tersimpan.\n'
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
  printf '1. Ambil Place ID angka dari game Roblox yang ingin dimainkan.\n'
  printf '2. Pilih menu 2 dan masukkan Place ID tersebut.\n'
  printf '3. Pilih menu 1 agar Roblox dibuka ke game itu.\n'
  printf 'MOCHI tidak menyimpan sandi, cookie, token, atau data akun.\n'
  pause
}

load_config

if [ "$#" -gt 0 ]; then
  if is_place_id "$1"; then
    open_game_by_id "$1"
    exit 0
  fi
  printf 'Place ID tidak valid. Masukkan angka saja.\n' >&2
  exit 2
fi

while :; do
  banner
  printf '1.  Buka Game Roblox\n'
  printf '2.  Set Place ID\n'
  printf '3.  Lihat Konfigurasi\n'
  printf '4.  Periksa Dependensi\n'
  printf '5.  Buka Roblox Home\n'
  printf '6.  Cara Menggunakan\n'
  printf '7.  Status Privasi\n'
  printf '8.  Tampilkan Place ID\n'
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
    2) set_place_id ;;
    3) show_config ;;
    4) check_tools ;;
    5) open_url 'https://www.roblox.com/home'; printf 'Membuka Roblox Home...\n'; pause ;;
    6) show_help ;;
    7) printf 'MOCHI tidak memakai root, cookie, token, maupun data akun.\n'; pause ;;
    8) show_config ;;
    9) open_url 'https://github.com/azka150104-hub/mochi-termux'; printf 'Membuka dokumentasi GitHub...\n'; pause ;;
    10) printf 'MOCHI v1.1 — launcher Roblox berbasis Place ID untuk Termux.\n'; pause ;;
    11) printf 'Pasang kebutuhan dengan: pkg install git termux-tools\n'; pause ;;
    12) load_config; printf 'Konfigurasi dimuat ulang.\n'; pause ;;
    0) printf '\nSampai jumpa.\n'; exit 0 ;;
    *) printf '\nPilihan tidak tersedia.\n'; pause ;;
  esac
done
