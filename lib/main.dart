// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uts_bloc/bloc/catatan_bloc.dart';
import 'package:uts_bloc/state/catatan_state.dart';
import 'package:uts_bloc/event/catatan_event.dart';
import 'package:uts_bloc/tambah_catatan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatatanBloc(),
      child: MaterialApp(
        title: 'FinansialKu',
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Keuangan'),
      ),
      body: SafeArea(
        child: BlocBuilder<CatatanBloc, CatatanState>(
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text('Total Pemasukkan: Rp${state.totalPemasukkan}'),
                  SizedBox(height: 20),
                  Text('Total Pengeluaran: Rp${state.totalPengeluaran}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Menavigasi ke halaman Tambah Catatan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TambahCatatanPage()),
                      );
                    },
                    child: Text('Tambah Catatan Finansial'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.daftarCatatan.length,
                      itemBuilder: (context, index) {
                        final catatan = state.daftarCatatan[index];
                        return ListTile(
                          title: Text(catatan['judul'] ?? ''),
                          subtitle: Text('Rp${catatan['jumlah']}'),
                          leading: Text(
                            catatan['kategori'] == 'Pemasukkan' ? '💰' : '💸',
                            style: TextStyle(fontSize: 24),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Tampilkan dialog konfirmasi sebelum menghapus
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Konfirmasi Hapus'),
                                    content: Text('Apakah Anda yakin ingin menghapus catatan ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Tutup dialog
                                        },
                                        child: Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          BlocProvider.of<CatatanBloc>(context)
                                              .add(HapusCatatan(index: index));
                                          Navigator.of(context).pop(); // Tutup dialog
                                        },
                                        child: Text('Hapus'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
