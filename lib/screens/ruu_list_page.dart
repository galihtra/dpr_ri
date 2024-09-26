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
  List<Ruu> allRuuList = []; // To store the complete list of RUU
  List<Ruu> filteredRuuList = []; // To store the filtered results
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureRuuList = ApiService().fetchRuu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (query) {
            setState(() {
              searchQuery = query;
              filteredRuuList = allRuuList
                  .where((ruu) => ruu.judul.toLowerCase().contains(searchQuery.toLowerCase()))
                  .toList();
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search RUU...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<Ruu>>(
        future: futureRuuList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available', style: TextStyle(fontSize: 18, color: Colors.grey)));
          } else {
            if (allRuuList.isEmpty) {
              allRuuList = snapshot.data!;
              filteredRuuList = allRuuList; // Initially, all data is shown
            }
            return ListView.builder(
              itemCount: filteredRuuList.length,
              itemBuilder: (context, index) {
                final ruu = filteredRuuList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        ruu.judul,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Pengusul: ${ruu.pengusul}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RuuDetailScreen(ruuId: ruu.id),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
