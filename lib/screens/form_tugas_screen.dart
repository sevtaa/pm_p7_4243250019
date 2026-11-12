import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/tugas_provider.dart';

class FormTugasScreen extends StatefulWidget {
  const FormTugasScreen({super.key});

  @override
  State<FormTugasScreen> createState() => _FormTugasScreenState();
}

class _FormTugasScreenState extends State<FormTugasScreen> {
  // Controller dideklarasikan di dalam State
  late TextEditingController _judulController;
  late TextEditingController _mataKuliahController;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller di initState
    _judulController = TextEditingController();
    _mataKuliahController = TextEditingController();
  }

  @override
  void dispose() {
    // Wajib membersihkan controller di dispose untuk mencegah memory leak
    _judulController.dispose();
    _mataKuliahController.dispose();
    super.dispose();
  }

  void _simpanTugas() {
    if (_judulController.text.trim().isEmpty ||
        _mataKuliahController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul dan Mata Kuliah tidak boleh kosong!'),
        ),
      );
      return;
    }

    // Tambah tugas ke state bersama
    context.read<TugasProvider>().tambahTugas(
      _judulController.text.trim(),
      _mataKuliahController.text.trim(),
      _selectedDate,
    );

    // Kembali ke halaman daftar tugas utama
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas Kuliah'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(
                labelText: 'Judul Tugas',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assignment),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _mataKuliahController,
              decoration: const InputDecoration(
                labelText: 'Mata Kuliah',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.book),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              title: Text(
                'Tanggal Tenggat: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (picked != null && mounted) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _simpanTugas,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Tugas'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
