# Film Favorit

Aplikasi mobile manajemen data film favorit berbasis Flutter dan Supabase.

---

## Deskripsi Aplikasi

Film Favorit adalah aplikasi mobile yang dikembangkan menggunakan framework Flutter dengan bahasa pemrograman Dart. Aplikasi ini memungkinkan pengguna untuk mencatat dan mengelola koleksi film favorit mereka secara personal. Data aplikasi disimpan secara permanen menggunakan Supabase sebagai backend database, sehingga data tidak akan hilang meskipun aplikasi ditutup.

Pengguna dapat mendaftarkan akun dan masuk menggunakan email dan password melalui fitur autentikasi Supabase Auth. Setelah masuk, pengguna dapat menambahkan film baru dengan mengisi informasi berupa judul, genre, dan sutradara. Data film yang telah disimpan dapat dilihat, diubah, maupun dihapus kapan saja. Aplikasi ini juga mendukung tampilan Light Mode dan Dark Mode yang dapat disesuaikan dengan preferensi pengguna.

---

## Fitur Aplikasi

| Fitur | Keterangan |
|-------|------------|
| Register | Membuat akun baru menggunakan email dan password |
| Login | Masuk ke aplikasi menggunakan akun yang sudah terdaftar |
| Logout | Keluar dari akun |
| Tambah Film (Create) | Menambahkan data film baru melalui form input |
| Lihat Daftar Film (Read) | Menampilkan seluruh data film dari Supabase |
| Lihat Detail Film | Menampilkan informasi lengkap satu film |
| Edit Film (Update) | Mengubah data film yang sudah ada |
| Hapus Film (Delete) | Menghapus data film dari database |
| Light Mode dan Dark Mode | Mengubah tampilan terang atau gelap |
| Validasi Form | Memastikan semua field terisi sebelum data disimpan |
| Multi-Page Navigation | Navigasi antar halaman menggunakan GetX |

---

## Widget yang Digunakan

### StatelessWidget
StatelessWidget adalah widget yang tidak memiliki state yang berubah. Digunakan untuk tampilan yang bersifat statis.

| Widget | Digunakan Pada |
|--------|---------------|
| `MyApp` | Konfigurasi utama aplikasi |

### StatefulWidget
StatefulWidget adalah widget yang memiliki state yang dapat berubah sewaktu-waktu. Pada aplikasi ini, pengelolaan state dilakukan menggunakan GetX dengan `GetxController`, sehingga tidak banyak StatefulWidget yang digunakan secara langsung.

| Widget | Digunakan Pada |
|--------|---------------|
| `GetView` | Semua halaman (HomeView, FormView, DetailView, LoginView, RegisterView) |

### GetX Controller
Controller GetX menggantikan fungsi StatefulWidget dalam mengelola state dan logika aplikasi.

| Controller | Fungsi |
|------------|--------|
| `HomeController` | Mengelola daftar film, hapus, navigasi |
| `FormController` | Mengelola form tambah dan edit film |
| `DetailController` | Mengelola detail dan hapus film |
| `AuthController` | Mengelola login, register, logout |
| `ThemeController` | Mengelola pergantian Light Mode dan Dark Mode |

---

## Navigasi

Aplikasi ini menggunakan navigasi GetX dengan fungsi:

| Fungsi | Keterangan |
|--------|------------|
| `Get.toNamed()` | Berpindah ke halaman baru |
| `Get.back()` | Kembali ke halaman sebelumnya |
| `Get.offAllNamed()` | Pindah halaman dan hapus semua stack |

---

## Struktur Project

```
lib/
├── controllers/
│   └── theme_controller.dart
├── data/
│   └── models/
│       └── film.dart
├── modules/
│   ├── auth/
│   │   ├── auth_controller.dart
│   │   ├── login_view.dart
│   │   └── register_view.dart
│   ├── home/
│   │   ├── home_controller.dart
│   │   └── home_view.dart
│   ├── form/
│   │   ├── form_controller.dart
│   │   └── form_view.dart
│   └── detail/
│       ├── detail_controller.dart
│       └── detail_view.dart
├── routes/
│   ├── app_pages.dart
│   └── app_routes.dart
└── main.dart
```

---

## Teknologi yang Digunakan

| Teknologi | Keterangan |
|-----------|------------|
| Flutter | Framework pengembangan aplikasi mobile |
| Dart | Bahasa pemrograman |
| Supabase | Backend database dan autentikasi |
| GetX | State management dan navigasi |
| flutter_dotenv | Menyimpan konfigurasi environment |

---

gabisa up gambar bang mba saya jadikan folder aja

