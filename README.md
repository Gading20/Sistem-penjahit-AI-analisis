# Sistem Penjahit AI Analisis

**Jahitln (TailorLink)** — Aplikasi manajemen jasa penjahit berbasis mobile + web dilengkapi analisis data dan AI.

## Struktur Proyek

```
├── data/                          # Analisis data (Jupyter Notebook, CSV)
│   ├── analisis_penjahit_shopee.ipynb
│   ├── produk_fashion.csv
│   ├── simulasi_feedback.csv
│   └── simulasi_pesanan.csv
└── tailor/                        # Aplikasi utama
    ├── backend/                   # REST API Flask + Web Dashboard
    ├── lib/                       # Flutter mobile app (GetX)
    └── database/                  # SQL dump database
```

## Persiapan

### Prasyarat

- Python 3.10+
- MySQL (XAMPP / Laragon)
- Flutter SDK
- Ngrok (untuk expose backend ke public)
- Git

### 1. Clone Repo

```bash
git clone https://github.com/Gading20/Sistem-penjahit-AI-analisis.git
cd Sistem-penjahit-AI-analisis
```

---

## A. Backend (Flask API)

### 1. Setup Database

Import file SQL ke MySQL:

```bash
# XAMPP
mysql -u root -p tailorlink_db < tailor/database/jahit.sql

# atau buka phpMyAdmin → import tailor/database/jahit.sql
```

### 2. Install Dependencies

```bash
cd tailor/backend
pip install -r requirements.txt
```

### 3. Konfigurasi Environment

Buat file `.env` di `tailor/backend/.env`:

```env
DB_HOST=localhost
DB_USER=root
DB_PASS=
DB_NAME=tailorlink_db
SECRET_KEY=your-secret-key
JWT_SECRET=your-jwt-secret
ADMIN_DEFAULT_PASSWORD=admin123
```

### 4. Jalankan Backend

```bash
flask run --debug
```

Backend akan berjalan di `http://127.0.0.1:5000`.

Admin akan otomatis dibuat saat pertama kali dijalankan:
- Username: `admin`
- Password: dari `ADMIN_DEFAULT_PASSWORD` di `.env` (atau random jika tidak diset, muncul di console)

### 5. Expose dengan Ngrok

```bash
ngrok config add-authtoken <token-ngrok-mu>
ngrok http 5000
```

Copy URL ngrok (misal `https://xxx.ngrok-free.dev`) dan update di file:
`tailor/lib/app/data/providers/api_provider.dart` → ganti `baseUrl`.

---

## B. Flutter Mobile App

### 1. Install Dependencies

```bash
cd tailor
flutter pub get
```

### 2. Jalankan Aplikasi

```bash
flutter run
```

Aplikasi akan terinstall di emulator / device yang terhubung.

### Command Lainnya

| Perintah | Fungsi |
|---|---|
| `flutter pub get` | Install dependencies |
| `dart analyze` | Cek kode (lint + type) |
| `flutter test` | Jalankan unit test |
| `dart run flutter_launcher_icons:generate` | Generate icon aplikasi |

### Route Aplikasi

| Halaman | Route |
|---|---|
| Login | `/login` |
| Register | `/register` |
| Home | `/home` |
| Detail Penjahit | `/tailor-detail` |
| Form Order | `/order-form` |
| Customize | `/customize` |
| Orders | `/orders` |
| Tracking | `/tracking` |
| Profile | `/profile` |
| Dashboard | `/dashboard` |
| Explore | `/explore` |
| Favourite | `/favourite` |

---

## C. Data Analysis (Jupyter Notebook)

Folder `data/` berisi analisis data penjahit Shopee menggunakan Python.

### Install Dependencies Analisis

```bash
pip install pandas matplotlib seaborn jupyter
```

### Jalankan Notebook

```bash
jupyter notebook data/analisis_penjahit_shopee.ipynb
```

Notebook ini mencakup:
- Analisis produk fashion paling populer
- Tren rating pelanggan
- Analisis penjualan harian/mingguan/bulanan
- Support demo data default atau upload CSV dari Shopee Seller Center

---

## Catatan Penting

- **Backend & Mobile harus jalan bersamaan** agar aplikasi berfungsi penuh.
- Semua pesan error API menggunakan **Bahasa Indonesia**.
- Web dashboard admin/owner bisa diakses via browser setelah backend jalan.
- Urutan status order: `pending → accepted → fitting → diproses → dijahit → selesai / siap_diambil` (atau `rejected`).
- File upload dibatasi max 5MB, format: `png/jpg/jpeg/webp`.
