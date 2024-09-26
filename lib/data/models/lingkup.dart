class Lingkup {
  final String akd;

  Lingkup({required this.akd});

  factory Lingkup.fromJson(Map<String, dynamic> json) {
    return Lingkup(
      akd: json['akd'] ?? 'Data not available',
    );
  }
}
