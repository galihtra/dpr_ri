class RekamJejak {
  final String tahap;
  final String agenda;
  final String tanggal;
  final String penjelasan;

  RekamJejak({
    required this.tahap,
    required this.agenda,
    required this.tanggal,
    required this.penjelasan,
  });

  factory RekamJejak.fromJson(Map<String, dynamic> json) {
    return RekamJejak(
      tahap: json['tahap'] ?? 'Data not available',
      agenda: json['agenda'] ?? 'Data not available',
      tanggal: json['tanggal'] ?? 'Data not available',
      penjelasan: json['penjelasan'] ?? 'Data not available',
    );
  }
}
