class Pengusul {
  final String namaPengusul;
  final String subPengusul;
  final String detailPengusul;

  Pengusul({
    required this.namaPengusul,
    required this.subPengusul,
    required this.detailPengusul,
  });

  factory Pengusul.fromJson(Map<String, dynamic> json) {
    return Pengusul(
      namaPengusul: json['nama_pengusul'] ?? 'Data not available',
      subPengusul: json['sub_pengusul'] ?? 'Data not available',
      detailPengusul: json['detail_pengusul'] ?? 'Data not available',
    );
  }
}
