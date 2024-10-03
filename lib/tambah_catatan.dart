// lib/tambah_catatan_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Impor untuk FilteringTextInputFormatter
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uts_bloc/bloc/catatan_bloc.dart';
import 'package:uts_bloc/event/catatan_event.dart';

class TambahCatatanPage extends StatefulWidget {
  @override
  _TambahCatatanPageState createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  String? _selectedCategory;
  List<String> _categories = ['Pemasukkan', 'Pengeluaran'];
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Catatan Finansial'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: _judulController,
                  decoration: InputDecoration(
                    labelText: 'Judul Catatan',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedCategory,
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _jumlahController,
                  decoration: InputDecoration(
                    labelText: 'Jumlah Uang',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly, // Pastikan ini ada
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Memeriksa apakah semua field terisi
                    if (_judulController.text.isNotEmpty &&
                        _selectedCategory != null &&
                        _jumlahController.text.isNotEmpty) {
                      // Menambahkan catatan ke bloc
                      BlocProvider.of<CatatanBloc>(context).add(
                        TambahCatatan(
                          judul: _judulController.text,
                          kategori: _selectedCategory!,
                          jumlah: _jumlahController.text,
                        ),
                      );
                      Navigator.pop(context); // Kembali ke halaman utama
                    } else {
                      // Tampilkan pesan jika ada field yang kosong
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Mohon isi semua field')),
                      );
                    }
                  },
                  child: Text('Simpan Catatan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
