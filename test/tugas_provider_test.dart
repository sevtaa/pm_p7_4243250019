import 'package:flutter_test/flutter_test.dart';
import 'package:pm_p7_4243250019/providers/tugas_provider.dart';

void main() {
  group('TugasProvider Test', () {
    test(
      '1. Menambah tugas baru berhasil memperbarui total dan tugas aktif',
      () {
        final provider = TugasProvider();
        final initialTotal = provider.totalTugas;

        // Memanggil method yang benar: tambahTugas
        provider.tambahTugas(
          'Belajar Flutter',
          'Pemrograman Mobile',
          DateTime.now(),
        );

        expect(provider.totalTugas, initialTotal + 1);
        expect(provider.tugasAktif, greaterThan(0));
      },
    );

    test('2. Mengubah status tugas (toggleStatus) memperbarui jumlah selesai & aktif', () {
      final provider = TugasProvider();
      final idTugasPertama = provider.daftarTugas.first.id;
      final initialSelesai = provider.tugasSelesai;

      provider.toggleStatus(idTugasPertama);

      expect(provider.tugasSelesai, initialSelesai + 1);
    });

    test('3. Menghapus tugas mengurangi total tugas keseluruhan', () {
      final provider = TugasProvider();
      final idTugasPertama = provider.daftarTugas.first.id;
      final initialTotal = provider.totalTugas;

      provider.hapusTugas(idTugasPertama);

      expect(provider.totalTugas, initialTotal - 1);
    });
  });
}
