import 'package:flutter/material.dart';
import '../data/models/detail_info_singkat.dart';
import '../data/service/api_service.dart';


class DetailScreen extends StatefulWidget {
  final String id;

  DetailScreen({required this.id});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<DetailInfoSingkat> futureDetailInfo;

  @override
  void initState() {
    super.initState();
    futureDetailInfo = ApiService().fetchDetailInfoSingkat(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Info Singkat'),
      ),
      body: FutureBuilder<DetailInfoSingkat>(
        future: futureDetailInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final detail = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(detail.gambarSampul),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(detail.judul, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('Penerbit: ${detail.penerbit}'),
                        SizedBox(height: 5),
                        Text('Bahasa: ${detail.bahasa}'),
                        SizedBox(height: 5),
                        Text('Subjek: ${detail.subjek}'),
                        SizedBox(height: 5),
                        Text('Tahun: ${detail.tahun}'),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Function to download file
                          },
                          child: Text('Download File'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
