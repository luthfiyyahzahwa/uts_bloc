// state/catatan_state.dart

class CatatanState {
  final List<Map<String, String>> daftarCatatan;
  final int totalPemasukkan;
  final int totalPengeluaran;

  CatatanState({
    this.daftarCatatan = const [],
    this.totalPemasukkan = 0,
    this.totalPengeluaran = 0,
  });
}
