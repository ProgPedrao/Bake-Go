import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bake_and_go/errors/http_exception.dart';
import 'package:bake_and_go/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token, String userId) async {
    try {
      _toggleFavorite();

      final response = await http.put(
        Uri.parse('${Contants.USER_FAVORITES_URL}/${userId}/${id}.json?auth=$token'),
        body: jsonEncode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (e) {
      _toggleFavorite();
    }
  }

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
