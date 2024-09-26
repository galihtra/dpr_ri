import 'package:dpr_ri/data/models/deskripsi_konsepsi.dart';
import 'package:dpr_ri/data/models/lingkup.dart';
import 'package:dpr_ri/data/models/pembahasan.dart';
import 'package:dpr_ri/data/models/pengusul.dart';
import 'package:dpr_ri/data/models/rekam_jejak.dart';


class RuuDetail {
  final String judul;
  final String tanggalPengusulan;
  final List<Pengusul> pengusul;
  final String status;
  final String keterangan;
  final Lingkup lingkup;
  final Pembahasan pembahasan;
  final DeskripsiKonsepsi? deskripsiKonsepsi; // Optional
  final List<RekamJejak>? rekamJejak; // Optional

  RuuDetail({
    required this.judul,
    required this.tanggalPengusulan,
    required this.pengusul,
    required this.status,
    required this.keterangan,
    required this.lingkup,
    required this.pembahasan,
    this.deskripsiKonsepsi, // Nullable
    this.rekamJejak, // Nullable
  });

  factory RuuDetail.fromJson(Map<String, dynamic> json) {
    // Handle the 'pengusul' field, which can be a List or a Map
    List<Pengusul> pengusulItems = [];
    if (json['pengusul'] != null && json['pengusul']['item'] != null) {
      if (json['pengusul']['item'] is List) {
        pengusulItems = (json['pengusul']['item'] as List)
            .map((item) => Pengusul.fromJson(item))
            .toList();
      } else if (json['pengusul']['item'] is Map) {
        pengusulItems.add(Pengusul.fromJson(json['pengusul']['item']));
      }
    }

    // Handle 'rekam_jejak', which is a List
    List<RekamJejak> rekamJejakItems = [];
    if (json['rekam_jejak'] != null && json['rekam_jejak']['item'] != null) {
      if (json['rekam_jejak']['item'] is List) {
        rekamJejakItems = (json['rekam_jejak']['item'] as List)
            .map((item) => RekamJejak.fromJson(item))
            .toList();
      }
    }

    // Handle nullable 'deskripsi_konsepsi'
    DeskripsiKonsepsi? deskripsiKonsepsi;
    if (json['deskripsi_konsepsi'] != null && json['deskripsi_konsepsi']['dpr'] != null) {
      deskripsiKonsepsi = DeskripsiKonsepsi.fromJson(json['deskripsi_konsepsi']['dpr']);
    }

    return RuuDetail(
      judul: json['judul'] ?? 'Data not available',
      tanggalPengusulan: json['tanggal_pengusulan'] ?? 'Data not available',
      pengusul: pengusulItems,
      status: json['status'] ?? 'Data not available',
      keterangan: json['keterangan'] ?? 'Data not available',
      lingkup: Lingkup.fromJson(json['lingkup']['item']),
      pembahasan: Pembahasan.fromJson(json['pembahasan']),
      deskripsiKonsepsi: deskripsiKonsepsi, // Nullable
      rekamJejak: rekamJejakItems.isNotEmpty ? rekamJejakItems : null, // Nullable
    );
  }
}

