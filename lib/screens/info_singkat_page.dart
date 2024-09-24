import 'package:dpr_ri/screens/detail_info_singkat_page.dart';
import 'package:flutter/material.dart';
import '../data/models/info_singkat.dart';
import '../data/service/api_service.dart';


class InfoSingkatScreen extends StatefulWidget {
  @override
  _InfoSingkatScreenState createState() => _InfoSingkatScreenState();
}

class _InfoSingkatScreenState extends State<InfoSingkatScreen> {
  late Future<List<InfoSingkat>> futureInfoSingkat;

  @override
  void initState() {
    super.initState();
    futureInfoSingkat = ApiService().fetchInfoSingkat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Singkat'),
      ),
      body: FutureBuilder<List<InfoSingkat>>(
        future: futureInfoSingkat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final info = snapshot.data![index];
                return ListTile(
                  leading: Image.network(info.gambarSampul),
                  title: Text(info.judul),
                  subtitle: Text(info.penerbit),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(id: info.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
