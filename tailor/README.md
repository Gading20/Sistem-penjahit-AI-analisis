# Jahitln — Mobile App & Backend

Aplikasi manajemen jasa penjahit berbasis Flutter (mobile) + Flask (backend).

## Quick Start

```bash
# 1. Import database
mysql -u root -p tailorlink_db < database/jahit.sql

# 2. Jalankan backend
cd backend
pip install -r requirements.txt
flask run --debug

# 3. Expose dengan ngrok (terminal baru)
ngrok http 5000

# 4. Update baseUrl di lib/app/data/providers/api_provider.dart
#    dengan URL ngrok

# 5. Jalankan Flutter
cd ..
flutter pub get
flutter run
```

Lihat panduan lengkap di [README.md](../README.md) (root proyek).
