import 'dart:convert';
import 'package:trelza_peekpub/features/package_page/model/info_model.dart';
import 'package:http/http.dart' as http;

class PubDevService {
  Future<PackageInfoModel?> fetchPackageInfo(String packageName) async {
    final url = Uri.parse('https://pub.dev/api/packages/$packageName');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PackageInfoModel.fromJson(packageName, data);
      } else {
        print('Failed to fetch package data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching package info: $e');
      return null;
    }
  }
}
