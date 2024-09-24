import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/detail_info_singkat.dart';
import '../models/info_singkat.dart';

class ApiService {
  static const String apiUrl =
      'https://jdih.dpr.go.id/api/get-all-info-singkat';
  static const String apiUrlDetail =
      'https://jdih.dpr.go.id/api/get-detail-info-singkat/id/';
  static const String token = 'JdihMobile@290845';

  
  Map<String, String> _buildHeaders() {
    return {
      'Authorization': 'Bearer $token',
    };
  }

  // Fetch list info singkat
  Future<List<InfoSingkat>> fetchInfoSingkat() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: _buildHeaders(),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => InfoSingkat.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<DetailInfoSingkat> fetchDetailInfoSingkat(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrlDetail$id'),
        headers: _buildHeaders(),
      );

      print('Response status: ${response.statusCode}');
      print(
          'Response body: ${response.body}'); 

      if (response.statusCode == 200) {
        
        if (response.headers['content-type']?.contains('application/json') ==
            true) {
          Map<String, dynamic> jsonResponse = json.decode(response.body);
          print('Decoded JSON: $jsonResponse');
          return DetailInfoSingkat.fromJson(jsonResponse['data']);
        } else {
          throw Exception('Response is not in JSON format');
        }
      } else {
        throw Exception('Failed to load detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
