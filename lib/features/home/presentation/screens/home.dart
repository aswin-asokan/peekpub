import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trelza_peekpub/features/home/model/package_model.dart';
import 'package:trelza_peekpub/features/home/presentation/widgets/error_card.dart';
import 'package:trelza_peekpub/features/home/presentation/widgets/list_card.dart';
import 'package:trelza_peekpub/features/home/presentation/widgets/loading.dart';
import 'package:trelza_peekpub/features/home/services/package_service.dart';
import 'package:trelza_peekpub/features/package_page/screens/package_page.dart';
import 'package:trelza_peekpub/shared/extensions/app_theme_extensions.dart';
import 'package:trelza_peekpub/shared/widgets/custom_appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key}); // Changed from Home to Home

  @override
  State<Home> createState() => _HomeState(); // Changed from _HomeState
}

class _HomeState extends State<Home> {
  // --- State Variables ---
  List<PackageInfo> _packages = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _error;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Timer? _debounce;

  // Service instance
  late final PackageService _packageService;

  @override
  void initState() {
    super.initState();
    _packageService = PackageService(); // Initialize the service
    _loadPackages(); // Initial load

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _loadPackages(); // Load more on scroll
      }
    });

    _searchController.addListener(() {
      _onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    _packageService.dispose(); // Dispose the service client if necessary
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final newQuery = query.trim();
      if (newQuery != _searchQuery) {
        _performSearch(newQuery);
      } else if (newQuery.isEmpty && _searchQuery.isNotEmpty) {
        _performSearch(''); // Handle clearing the search
      }
    });
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      _packages = []; // Clear current packages
      _currentPage = 1; // Reset page
      _hasMore = true; // Assume there are more packages for the new query
      _error = null; // Clear previous errors
      _isLoading = false; // Reset loading state before new fetch
    });
    _loadPackages(isNewSearch: true);
  }

  Future<void> _loadPackages({bool isNewSearch = false}) async {
    if (_isLoading || (!isNewSearch && !_hasMore)) return;

    setState(() {
      _isLoading = true;
      if (isNewSearch) {
        _error = null; // Clear error for new search/load attempt
      }
    });

    final result = await _packageService.fetchPackages(
      searchQuery: _searchQuery,
      page: _currentPage,
    );

    if (!mounted) return; // Check if the widget is still in the tree

    setState(() {
      if (result.error != null) {
        _error = result.error;
        _hasMore = false; // Stop pagination on error
      } else {
        if (isNewSearch) {
          _packages = result.packages;
        } else {
          _packages.addAll(result.packages);
        }
        _hasMore = result.hasMore;
        if (result.hasMore || result.packages.isNotEmpty) {
          // Increment page only if data was fetched or more is expected
          _currentPage++;
        }
      }
      _isLoading = false;
    });
  }

  void _retryFetch() {
    setState(() {
      _packages = [];
      _currentPage = 1;
      _hasMore = true;
      _error = null;
      _isLoading = false;
    });
    _loadPackages(isNewSearch: true);
  }

  void showPackageInfo(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PackagePage(
              packageName: _packages[index].name,
              packageVersion: _packages[index].latestVersion,
              packageDescription: _packages[index].description ?? '',
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: context.loc.home,
        textcontroller: _searchController,
        retryFunction: _retryFetch,
      ),
      body: Column(
        children: [
          // --- Error Display ---
          if (_error != null && _packages.isEmpty && !_isLoading)
            ErrorCard(error: _error!, onPress: _retryFetch),

          // --- No Results Found (for search) ---
          if (_searchQuery.isNotEmpty &&
              _packages.isEmpty &&
              !_isLoading &&
              _error == null)
            SearchNotFound(query: _searchQuery),

          // --- Package List ---
          // Ensure this Expanded widget is only built if there's no error taking full screen
          // or no "no results" message taking full screen.
          if (!(_error != null && _packages.isEmpty && !_isLoading) &&
              !(_searchQuery.isNotEmpty &&
                  _packages.isEmpty &&
                  !_isLoading &&
                  _error == null))
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount:
                    _packages.length +
                    (_hasMore || _isLoading
                        ? 1
                        : 0), // Adjust itemCount for loader/end message
                itemBuilder: (context, index) {
                  // Check if the current index is for a package item or the loader/end message
                  if (index < _packages.length) {
                    // Display package information
                    final package = _packages[index];
                    return ListCard(
                      name: package.name,
                      description:
                          (package.description?.isNotEmpty ?? false)
                              ? package.description!
                              : "no description",
                      version: package.latestVersion,
                      onPress: () {
                        showPackageInfo(index);
                      },
                    );
                  } else {
                    // This is the item after the last package: show loader or end message
                    if (_isLoading) {
                      return Loading();
                    } else if (!_hasMore && _packages.isNotEmpty) {
                      // This is the selected code block's logic
                      return ListEnd(query: _searchQuery);
                    } else {
                      // If not loading, and no more items (or packages list is empty but _hasMore was true initially)
                      // return an empty container. This handles cases where _hasMore might be true
                      // but fetchedPackages was empty, or initial load where _packages is empty.
                      return const SizedBox.shrink();
                    }
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
