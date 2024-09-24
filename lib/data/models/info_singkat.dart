class InfoSingkat {
  final String id;
  final String judul;
  final String penerbit;
  final String bahasa;
  final String fileDownload;
  final String gambarSampul;

  InfoSingkat({
    required this.id,
    required this.judul,
    required this.penerbit,
    required this.bahasa,
    required this.fileDownload,
    required this.gambarSampul,
  });

  factory InfoSingkat.fromJson(Map<String, dynamic> json) {
    return InfoSingkat(
      id: json['id'],
      judul: json['judul'],
      penerbit: json['penerbit'],
      bahasa: json['bahasa'],
      fileDownload: json['urlDownload'],
      gambarSampul: json['gambarSampul'],
    );
  }
}
