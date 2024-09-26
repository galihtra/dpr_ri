class Pembahasan {
  final String penjelasan;
  final String tahapan;

  Pembahasan({
    required this.penjelasan,
    required this.tahapan,
  });

  factory Pembahasan.fromJson(Map<String, dynamic> json) {
    return Pembahasan(
      penjelasan: json['penjelasan'] ?? 'Data not available',
      tahapan: json['tahapan'] ?? 'Data not available',
    );
  }
}
