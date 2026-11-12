import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tugas_provider.dart';

class DaftarTugasScreen extends StatefulWidget {
  const DaftarTugasScreen({super.key});

  @override
  State<DaftarTugasScreen> createState() => _DaftarTugasScreenState();
}

class _DaftarTugasScreenState extends State<DaftarTugasScreen> {
  // Ephemeral state untuk filter kategori (dikelola setState)
  String _filterKategori = 'Semua';

  @override
  Widget build(BuildContext context) {
    final tugasProvider = context.watch<TugasProvider>();
    final semuaTugas = tugasProvider.daftarTugas;

    final filteredTugas = semuaTugas.where((t) {
      if (_filterKategori == 'Aktif') return !t.selesai;
      if (_filterKategori == 'Selesai') return t.selesai;
      return true; // 'Semua'
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planner Tugas Kuliah'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // FilterChip (Ephemeral state dengan setState)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              spacing: 8.0,
              children: ['Semua', 'Aktif', 'Selesai'].map((kategori) {
                return ChoiceChip(
                  label: Text(kategori),
                  selected: _filterKategori == kategori,
                  onSelected: (selected) {
                    setState(() {
                      _filterKategori = kategori;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: filteredTugas.isEmpty
                ? const Center(
                    child: Text('Tidak ada tugas dalam kategori ini.'),
                  )
                : ListView.builder(
                    itemCount: filteredTugas.length,
                    itemBuilder: (context, index) {
                      final tugas = filteredTugas[index];
                      return Dismissible(
                        key: Key(tugas.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) {
                          context.read<TugasProvider>().hapusTugas(tugas.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('"${tugas.judul}" dihapus')),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: tugas.selesai,
                              onChanged: (_) {
                                context.read<TugasProvider>().toggleStatus(
                                  tugas.id,
                                );
                              },
                            ),
                            title: Text(
                              tugas.judul,
                              style: TextStyle(
                                decoration: tugas.selesai
                                    ? TextDecoration.lineThrough
                                    : null,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${tugas.mataKuliah} • Tenggat: ${tugas.tenggat.day}/${tugas.tenggat.month}/${tugas.tenggat.year}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                context.read<TugasProvider>().hapusTugas(
                                  tugas.id,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
