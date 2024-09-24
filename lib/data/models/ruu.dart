class Ruu {
  final String id;
  final String nomor;
  final String judul;
  final String pengusul;

  Ruu({
    required this.id,
    required this.nomor,
    required this.judul,
    required this.pengusul,
  });

  factory Ruu.fromJson(Map<String, dynamic> json) {
    return Ruu(
      id: json['id'] ?? '',
      nomor: json['nomor'] ?? '',
      judul: json['judul'] ?? 'Tidak ada judul',
      pengusul: json['pengusul'] ?? 'Tidak ada pengusul',
    );
  }
}
