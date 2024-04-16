import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gallery_poc/models/image.dart';
import 'package:gallery_poc/services/logger.dart';
import 'package:http/http.dart' as http;

class GalleryController extends ChangeNotifier {
  static const String apiUrl = "pixabay.com";
  final List<HitImage> _images = [];
  String _searchQuery = "";
  bool _isLoading = false;

  GalleryController() {
    logger.i('Gallery Controller initiated');
    browseImages();
  }

  set setSearchQuery(String value) {
    logger.i('Changing search query...');
    _searchQuery = value;
    notifyListeners();
  }

  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  List<HitImage> get images => _images;

  Future<void> browseImages() async {
    logger.i("Browsing...");
    _images.clear();
    _isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.https(apiUrl, '/api/',
        {"key": dotenv.env['PIXABAY_APIKEY'], "q": _searchQuery}));
    final hits = json.decode(response.body)['hits'] as List<dynamic>;

    populateImages(hits);
  }

  void populateImages(List<dynamic> hits) {
    logger.i("Populating...");
    for (final hit in hits) {
      _images.add(HitImage.fromJson(hit));
    }
    _isLoading = false;
    logger.i("Populated");
    notifyListeners();
  }
}
