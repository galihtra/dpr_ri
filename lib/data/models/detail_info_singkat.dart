class DetailInfoSingkat {
  final String id;
  final String judul;
  final String penerbit;
  final String bahasa;
  final String fileDownload;
  final String gambarSampul;
  final String tahun;
  final String subjek;

  DetailInfoSingkat({
    required this.id,
    required this.judul,
    required this.penerbit,
    required this.bahasa,
    required this.fileDownload,
    required this.gambarSampul,
    required this.tahun,
    required this.subjek,
  });

  factory DetailInfoSingkat.fromJson(Map<String, dynamic> json) {
    try {
      return DetailInfoSingkat(
        id: json['id'] ?? '',
        judul: json['judul'] ?? 'Tidak ada judul',
        penerbit: json['penerbit'] ?? 'Tidak ada penerbit',
        bahasa: json['bahasa'] ?? 'Tidak ada bahasa',
        fileDownload: json['urlDownload'] ?? '',
        gambarSampul: json['gambarSampul'] ?? '',
        tahun: json['tahun'] ?? 'Tidak ada tahun',
        subjek: json['subjek'] ?? 'Tidak ada subjek',
      );
    } catch (e) {
      throw Exception('Error parsing DetailInfoSingkat: $e');
    }
  }
}
