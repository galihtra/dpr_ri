import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/detail_ruu.dart';
import '../../models/ruu.dart';

class ApiService {
  static const String apiUrlRuu =
      'https://www.dpr.go.id/rest/?method=getAllRuu&jenis=prioritas&tahun=2015&tipe=json';

  static const String apiUrlRuuDetail =
      'https://www.dpr.go.id/rest/?method=getRuu&id=';

  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
    };
  }

  // Fungsi untuk fetch list RUU
  Future<List<Ruu>> fetchRuu() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrlRuu),
        headers: _buildHeaders(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['ruu']; // Array dari data RUU
        return data.map((json) => Ruu.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Fungsi untuk fetch detail RUU berdasarkan ID
  Future<RuuDetail> fetchRuuDetail(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrlRuuDetail$id&tipe=json'),
        headers: _buildHeaders(),
      );

      if (response.statusCode == 200) {
        print('Response body: ${response.body}'); // Log the response body

        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Directly create the RuuDetail object without accessing a 'data' key
        return RuuDetail.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load detail: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
