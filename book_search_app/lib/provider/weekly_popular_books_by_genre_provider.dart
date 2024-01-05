import 'dart:convert';

import 'package:book_search_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/weekly_popular_books_by_genre_model.dart';

class WeeklyPopularBooksByGenreProvider with ChangeNotifier {
  int statusCode = 0;
  List<WeeklyPopularBooksByGenreModel> _weeklyPopularBooksByGenre = [];

  List<WeeklyPopularBooksByGenreModel> get weeklyPopularBooksByGenre =>
      _weeklyPopularBooksByGenre;

  bool isLoading = false;

  Future<void> getWeeklyPopularBooksByGenre(String genre,
      {int itemCount = 10}) async {
    isLoading = true;

    final response = await http.get(
      Uri.parse('https://hapi-books.p.rapidapi.com/week/$genre/$itemCount'),
      headers: {
        'X-RapidAPI-Key': rapidAPIKey,
        'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> weeklyPopularBooksByGenreTemp = jsonDecode(response.body);

      _weeklyPopularBooksByGenre = weeklyPopularBooksByGenreTemp
          .map((dynamic item) => WeeklyPopularBooksByGenreModel.fromJson(item))
          .toList();
    } else {
      _weeklyPopularBooksByGenre = [];
    }
    statusCode = response.statusCode;
    isLoading = false;
    notifyListeners();
  }
}
