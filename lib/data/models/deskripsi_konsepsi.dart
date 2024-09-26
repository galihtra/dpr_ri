class DeskripsiKonsepsi {
  final String latarBelakangTujuan;
  final String jangkauanArah;
  final String dasarPembentukan;

  DeskripsiKonsepsi({
    required this.latarBelakangTujuan,
    required this.jangkauanArah,
    required this.dasarPembentukan,
  });

  factory DeskripsiKonsepsi.fromJson(Map<String, dynamic> json) {
    return DeskripsiKonsepsi(
      latarBelakangTujuan: json['latar_belakang_tujuan'] ?? 'Data not available',
      jangkauanArah: json['jangkauan_arah'] ?? 'Data not available',
      dasarPembentukan: json['dasar_pembentukan'] ?? 'Data not available',
    );
  }
}
