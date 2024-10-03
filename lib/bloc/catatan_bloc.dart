// bloc/catatan_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uts_bloc/event/catatan_event.dart';
import 'package:uts_bloc/state/catatan_state.dart';

class CatatanBloc extends Bloc<CatatanEvent, CatatanState> {
  CatatanBloc() : super(CatatanState()) {
    on<TambahCatatan>((event, emit) {
      final newCatatan = List<Map<String, String>>.from(state.daftarCatatan)
        ..add({
          'judul': event.judul,
          'kategori': event.kategori,
          'jumlah': event.jumlah,
        });

      // Update totals
      int totalPemasukkan = state.totalPemasukkan;
      int totalPengeluaran = state.totalPengeluaran;
      int jumlah = int.tryParse(event.jumlah) ?? 0;

      if (event.kategori == 'Pemasukkan') {
        totalPemasukkan += jumlah;
      } else {
        totalPengeluaran += jumlah;
      }

      emit(CatatanState(
        daftarCatatan: newCatatan,
        totalPemasukkan: totalPemasukkan,
        totalPengeluaran: totalPengeluaran,
      ));
    });

    on<HapusCatatan>((event, emit) {
      final newCatatan = List<Map<String, String>>.from(state.daftarCatatan);
      final catatan = newCatatan.removeAt(event.index);

      // Update totals based on the removed catatan
      int totalPemasukkan = state.totalPemasukkan;
      int totalPengeluaran = state.totalPengeluaran;
      int jumlah = int.tryParse(catatan['jumlah'] ?? '0') ?? 0;

      if (catatan['kategori'] == 'Pemasukkan') {
        totalPemasukkan -= jumlah;
      } else {
        totalPengeluaran -= jumlah;
      }

      emit(CatatanState(
        daftarCatatan: newCatatan,
        totalPemasukkan: totalPemasukkan,
        totalPengeluaran: totalPengeluaran,
      ));
    });
  }
}
