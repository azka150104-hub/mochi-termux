# MOCHI

Launcher game Roblox sederhana untuk Termux. Proyek ini hanya membuka halaman game resmi agar Anda dapat masuk dan bergabung sendiri melalui aplikasi atau browser Roblox.

MOCHI sengaja **tidak** menyediakan auto-rejoin, injeksi cookie, pengambilan token, akses root, atau kontrol banyak akun.

## Jalankan dari GitHub di Termux

1. Buat repositori GitHub baru, misalnya `mochi-termux`, lalu unggah dua berkas ini ke repositori tersebut.
2. Di Termux, jalankan perintah berikut.

```sh
pkg update -y && pkg install git termux-tools -y
git clone https://github.com/azka150104-hub/mochi-termux.git
cd mochi-termux
chmod +x mochi.sh
./mochi.sh
```

Atau jalankan langsung dengan tautan game:

```sh
./mochi.sh 'https://www.roblox.com/games/PLACE_ID'
```

Jika `termux-open-url` tidak tersedia, jalankan `pkg install termux-tools -y`, lalu buka ulang Termux.

## Menu MOCHI

Sesudah menjalankan `./mochi.sh`, ketik angka menu lalu tekan Enter:

- `2` — simpan URL game Roblox resmi Anda.
- `1` — buka game yang sudah disimpan pada aplikasi atau browser Roblox.
- `4` — cek apakah `git` dan `termux-open-url` sudah tersedia.
- `0` — keluar.

Pada penggunaan pertama, pilih `2` dahulu, tempel URL game resmi (misalnya `https://www.roblox.com/games/PLACE_ID`), lalu pilih `1` untuk membukanya.

## Prompt execute singkat

Setelah repositori sudah ada di GitHub, salin ini ke Termux:

```sh
pkg update -y && pkg install git termux-tools -y && git clone https://github.com/azka150104-hub/mochi-termux.git && cd mochi-termux && chmod +x mochi.sh && ./mochi.sh
```

Untuk pembaruan versi:

```sh
cd ~/mochi-termux && git pull --ff-only && ./mochi.sh
```

## Konfigurasi opsional

Supaya tidak mengetik tautan setiap kali membuka MOCHI:

```sh
echo "export MOCHI_GAME_URL='https://www.roblox.com/games/PLACE_ID'" >> ~/.bashrc
source ~/.bashrc
./mochi.sh
```

Ganti `PLACE_ID` dengan ID game yang Anda miliki dari URL game Roblox resmi.
