// event/catatan_event.dart

abstract class CatatanEvent {}

class TambahCatatan extends CatatanEvent {
  final String judul;
  final String kategori;
  final String jumlah;

  TambahCatatan(
      {required this.judul, required this.kategori, required this.jumlah});
}

class HapusCatatan extends CatatanEvent {
  final int index;

  HapusCatatan({required this.index});
}
