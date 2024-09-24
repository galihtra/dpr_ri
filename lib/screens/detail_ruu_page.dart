import 'package:dpr_ri/data/service/ruu/api_service_ruu.dart';
import 'package:flutter/material.dart';
import '../data/models/detail_ruu.dart';

class RuuDetailScreen extends StatefulWidget {
  final String ruuId;

  RuuDetailScreen({required this.ruuId});

  @override
  _RuuDetailScreenState createState() => _RuuDetailScreenState();
}

class _RuuDetailScreenState extends State<RuuDetailScreen> {
  late Future<RuuDetail> futureRuuDetail;

  @override
  void initState() {
    super.initState();
    futureRuuDetail = ApiService().fetchRuuDetail(widget.ruuId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail RUU'),
      ),
      body: FutureBuilder<RuuDetail>(
        future: futureRuuDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No detail available'));
          } else {
            final ruuDetail = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Judul: ${ruuDetail.judul}',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Nomor: ${ruuDetail.nomor}'),
                  SizedBox(height: 5),
                  Text('Pengusul:'),
                  ...ruuDetail.pengusul
                      .map((p) => Text(
                          '${p.namaPengusul} - ${p.subPengusul} (${p.detailPengusul})'))
                      .toList(),
                  SizedBox(height: 10),
                  Text('Lingkup: ${ruuDetail.lingkup.akd}'),
                  SizedBox(height: 10),
                  Text('Status: ${ruuDetail.status}'),
                  SizedBox(height: 10),
                  Text('Keterangan: ${ruuDetail.keterangan}'),
                  SizedBox(height: 10),
                  Text('Pembahasan: ${ruuDetail.pembahasan.penjelasan}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
