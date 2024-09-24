import 'package:dpr_ri/data/service/ruu/api_service_ruu.dart';
import 'package:dpr_ri/screens/detail_ruu_page.dart';
import 'package:flutter/material.dart';
import '../data/models/ruu.dart';

class RuuListScreen extends StatefulWidget {
  @override
  _RuuListScreenState createState() => _RuuListScreenState();
}

class _RuuListScreenState extends State<RuuListScreen> {
  late Future<List<Ruu>> futureRuuList;

  @override
  void initState() {
    super.initState();
    futureRuuList = ApiService().fetchRuu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar RUU'),
      ),
      body: FutureBuilder<List<Ruu>>(
        future: futureRuuList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final ruuList = snapshot.data!;
            return ListView.builder(
              itemCount: ruuList.length,
              itemBuilder: (context, index) {
                final ruu = ruuList[index];
                return ListTile(
                  title: Text(ruu.judul),
                  subtitle: Text('Pengusul: ${ruu.pengusul}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RuuDetailScreen(ruuId: ruu.id),
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
