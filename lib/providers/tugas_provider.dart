import 'package:flutter/foundation.dart';

import '../models/tugas_kuliah.dart';

class TugasProvider extends ChangeNotifier {
  final List<TugasKuliah> _daftarTugas = [
    TugasKuliah(
      id: '1',
      judul: 'Membuat Laporan Praktikum Mobile',
      mataKuliah: 'Pemrograman Mobile',
      tenggat: DateTime.now().add(const Duration(days: 2)),
      selesai: false,
    ),
    TugasKuliah(
      id: '2',
      judul: 'Analisis Jaringan Nirkabel',
      mataKuliah: 'Keamanan Komputer',
      tenggat: DateTime.now().add(const Duration(days: 4)),
      selesai: true,
    ),
  ];

  List<TugasKuliah> get daftarTugas => _daftarTugas;

  int get totalTugas => _daftarTugas.length;

  int get tugasSelesai => _daftarTugas.where((t) => t.selesai).length;

  int get tugasAktif => _daftarTugas.where((t) => !t.selesai).length;

  double get persentaseSelesai {
    if (totalTugas == 0) return 0.0;
    return (tugasSelesai / totalTugas) * 100;
  }

  void tambahTugas(String judul, String mataKuliah, DateTime tenggat) {
    final tugasBaru = TugasKuliah(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      judul: judul,
      mataKuliah: mataKuliah,
      tenggat: tenggat,
      selesai: false,
    );
    _daftarTugas.add(tugasBaru);
    notifyListeners();
  }

  void toggleStatus(String id) {
    final index = _daftarTugas.indexWhere((t) => t.id == id);
    if (index != -1) {
      _daftarTugas[index].selesai = !_daftarTugas[index].selesai;
      notifyListeners();
    }
  }

  void hapusTugas(String id) {
    _daftarTugas.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
