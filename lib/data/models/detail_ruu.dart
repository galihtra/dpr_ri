class RuuDetail {
  final String id; // Assuming you have a way to retrieve the ID
  final String nomor; // Assuming you have a way to retrieve the Nomor
  final String judul;
  final List<Pengusul> pengusul; // List of Pengusul
  final String status;
  final String keterangan;
  final Lingkup lingkup; // New Lingkup model
  final Pembahasan pembahasan; // New Pembahasan model

  RuuDetail({
    required this.id,
    required this.nomor,
    required this.judul,
    required this.pengusul,
    required this.status,
    required this.keterangan,
    required this.lingkup,
    required this.pembahasan,
  });

  

  factory RuuDetail.fromJson(Map<String, dynamic> json) {
    var pengusulList = json['pengusul']['item'] as List;
    List<Pengusul> pengusulItems =
        pengusulList.map((item) => Pengusul.fromJson(item)).toList();

    return RuuDetail(
      id: json['id'] ?? '', // Adjust accordingly if 'id' is not in the response
      nomor: json['nomor'] ??
          '', // Adjust accordingly if 'nomor' is not in the response
      judul: json['judul'],
      pengusul: pengusulItems,
      status: json['status'],
      keterangan: json['keterangan'],
      lingkup: Lingkup.fromJson(json['lingkup']['item']),
      pembahasan: Pembahasan.fromJson(json['pembahasan']),
    );
  }
}

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
      namaPengusul: json['nama_pengusul'],
      subPengusul: json['sub_pengusul'],
      detailPengusul: json['detail_pengusul'],
    );
  }
}

class Lingkup {
  final String akd;

  Lingkup({required this.akd});

  factory Lingkup.fromJson(Map<String, dynamic> json) {
    return Lingkup(
      akd: json['akd'],
    );
  }
}

class Pembahasan {
  final String penjelasan;
  final String tahapan;

  Pembahasan({
    required this.penjelasan,
    required this.tahapan,
  });

  factory Pembahasan.fromJson(Map<String, dynamic> json) {
    return Pembahasan(
      penjelasan: json['penjelasan'],
      tahapan: json['tahapan'],
    );
  }
}
