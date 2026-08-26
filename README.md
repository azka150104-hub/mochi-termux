# MOCHI

Launcher game Roblox sederhana untuk Termux. Proyek ini hanya membuka halaman game resmi agar Anda dapat masuk dan bergabung sendiri melalui aplikasi atau browser Roblox.

MOCHI sengaja **tidak** menyediakan auto-rejoin, injeksi cookie, pengambilan token, akses root, atau kontrol banyak akun.

## Jalankan dari GitHub di Termux

Di Termux, jalankan perintah berikut.

```sh
pkg update -y && pkg install git termux-tools -y
git clone https://github.com/azka150104-hub/mochi-termux.git
cd mochi-termux
chmod +x mochi.sh
./mochi.sh
```

Atau buka game langsung dengan Place ID angka:

```sh
./mochi.sh PLACE_ID
```

Jika `termux-open-url` tidak tersedia, jalankan `pkg install termux-tools -y`, lalu buka ulang Termux.

## Menu MOCHI

Sesudah menjalankan `./mochi.sh`, ketik angka menu lalu tekan Enter:

- `2` — simpan Place ID game Roblox (angka saja).
- `1` — buka game yang sudah disimpan pada aplikasi atau browser Roblox.
- `4` — cek apakah `git` dan `termux-open-url` sudah tersedia.
- `0` — keluar.

Pada penggunaan pertama, pilih `2` dahulu, masukkan Place ID game (misalnya `123456789`), lalu pilih `1` untuk membukanya.

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

Supaya tidak mengetik Place ID setiap kali membuka MOCHI:

```sh
echo "export MOCHI_PLACE_ID='PLACE_ID'" >> ~/.bashrc
source ~/.bashrc
./mochi.sh
```

Ganti `PLACE_ID` dengan ID angka game Roblox Anda.
