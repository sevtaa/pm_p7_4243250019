class TugasKuliah {
  final String id;
  final String judul;
  final String mataKuliah;
  final DateTime tenggat;
  bool selesai;

  TugasKuliah({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    required this.tenggat,
    this.selesai = false,
  });

  TugasKuliah copyWith({
    String? judul,
    String? mataKuliah,
    DateTime? tenggat,
    bool? selesai,
  }) {
    return TugasKuliah(
      id: id,
      judul: judul ?? this.judul,
      mataKuliah: mataKuliah ?? this.mataKuliah,
      tenggat: tenggat ?? this.tenggat,
      selesai: selesai ?? this.selesai,
    );
  }
}
