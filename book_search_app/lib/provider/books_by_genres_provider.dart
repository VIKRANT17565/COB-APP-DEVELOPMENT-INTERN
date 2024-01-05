import 'dart:convert';

import 'package:book_search_app/globals.dart';
import 'package:book_search_app/model/books_by_genres_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BooksByGenresProvider with ChangeNotifier {
  int statusCode = 0;
  Map<String, List<BooksByGenresModel>> _booksByGenres = {};

  Map<String, List<BooksByGenresModel>> get booksByGenres => _booksByGenres;

  bool isLoading = false;

  Future<void> getBooksByGenres(String genre) async {
    isLoading = true;

    final response = await http.get(
      Uri.parse(
          'https://books-api7.p.rapidapi.com/books/find/genres?genres%5B%5D=$genre'),
      headers: {
        'X-RapidAPI-Key': rapidAPIKey,
        'X-RapidAPI-Host': 'books-api7.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> booksByGenresTemp = jsonDecode(response.body);

      _booksByGenres[genre] = booksByGenresTemp
          .map((dynamic item) => BooksByGenresModel.fromJson(item))
          .toList();
    } else {
      _booksByGenres = {};
    }
    statusCode = response.statusCode;
    isLoading = false;
    notifyListeners();
  }
}
