# cart_app

Cart Flutter project

1. Jelaskan perbedaan antara Cubit dan Bloc dalam arsitekstur
    Cubit: Mengubah state secara langsung dengan memanggil method dan melakukan emit(stateBaru).
    Bloc: Mengubah state lewat event, yang kemudian diproses di fungsi mapEventToState.

    Cubit: navigasi hanya 1 halaman
    Bloc: multi halaman

    Cubit: Widget ListView
    Bloc: ListView, GridView, Stack

    Cubit: UI flat
    Bloc: UI memakai material design, animation, dan responsive

3. Mengapa penting untuk memisahkan antara model data, logika bisnis, dan UI dalam pengembangan aplikasi Flutter?

Dengan memisahkan UI, model, dan logika bisnis, aplikasi lebih mudah dikembangkan seiring bertambahnya fitur. Setiap bagian tidak saling mengganggu.

Model data bisa digunakan ulang di banyak tempat tanpa duplikasi kode.
Cubit/Bloc bisa dipakai lintas layar tanpa memodifikasi UI.

Perbaikan dan debugging menjadi jauh lebih mudah.
Jika terjadi error, kamu tahu itu berasal dari:
-data
-cubit/bloc
-ui
Semua jelas terpisah.

Unit test ideal dilakukan pada logika bisnis (Cubit/Bloc), bukan UI.
Dengan pemisahan, kita bisa:
test perubahan state
test kalkulasi
test validasi
Tanpa memuat widget.

3. Sebutkan dan jelaskan minimal tiga state yang mungkin digunakan dalam CartCubit beserta fungsinya!
class State awal ketika Cubit baru diinisialisasi. Biasanya berisi list produk kosong.

class CartUpdated extends CartState. Menandakan bahwa igit push -u origin mainsi keranjang telah berubah (produk ditambah, dihapus, atau jumlah diubah).

class CartError extends CartState. Menandakan ada error dalam meng-update keranjang.


