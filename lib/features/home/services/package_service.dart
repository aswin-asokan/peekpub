import 'dart:convert';

import 'package:trelza_peekpub/features/home/model/package_model.dart';
import 'package:http/http.dart' as http;

class FetchResult {
  final List<PackageInfo> packages;
  final bool hasMore;
  final String? error;

  FetchResult({required this.packages, required this.hasMore, this.error});
}

class PackageService {
  final http.Client _client;

  // Allow injecting an HTTP client for testability
  PackageService({http.Client? client}) : _client = client ?? http.Client();

  Future<FetchResult> fetchPackages({
    required String searchQuery,
    required int page,
  }) async {
    Uri url;
    bool isSearchMode = searchQuery.isNotEmpty;

    if (isSearchMode) {
      url = Uri.parse('https://pub.dev/api/search?q=$searchQuery&page=$page');
    } else {
      url = Uri.parse('https://pub.dev/api/packages?page=$page');
    }

    try {
      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> packageListJson =
            data['packages'] ?? (data['results'] as List<dynamic>?) ?? [];

        List<PackageInfo> fetchedPackages = [];

        if (isSearchMode) {
          // Extract package names
          final List<String> packageNames =
              packageListJson
                  .map((e) => (e as Map<String, dynamic>)['package'] as String)
                  .toList();

          // Fetch full package info in parallel
          final packageDetailsResponses = await Future.wait(
            packageNames.map(
              (name) =>
                  http.get(Uri.parse('https://pub.dev/api/packages/$name')),
            ),
          );

          for (var response in packageDetailsResponses) {
            if (response.statusCode == 200) {
              final detailJson = json.decode(response.body);
              fetchedPackages.add(PackageInfo.fromJson(detailJson));
            }
          }
        } else {
          fetchedPackages =
              packageListJson
                  .map(
                    (jsonItem) =>
                        PackageInfo.fromJson(jsonItem as Map<String, dynamic>),
                  )
                  .toList();
        }

        final bool hasMore =
            (data['next_url'] != null || data['next'] != null) &&
            fetchedPackages.isNotEmpty;
        return FetchResult(packages: fetchedPackages, hasMore: hasMore);
      } else {
        return FetchResult(
          packages: [],
          hasMore: false,
          error: 'Failed to load packages. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return FetchResult(
        packages: [],
        hasMore: false,
        error: 'An error occurred: ${e.toString()}',
      );
    }
  }

  // Close the client when the service is no longer needed (optional, depends on lifecycle)
  void dispose() {
    _client.close();
  }
}
