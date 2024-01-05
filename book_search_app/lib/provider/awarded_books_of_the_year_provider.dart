import 'dart:convert';

import 'package:book_search_app/globals.dart';
import 'package:book_search_app/model/awarded_books_of_the_year_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AwardedBooksOfTheYearProvider with ChangeNotifier {
  int statusCode = 0;
  List<AwardedBooksOfTheYearModel> _awardedBooksOfTheYear = [];

  List<AwardedBooksOfTheYearModel> get awardedBooksOfTheYear =>
      _awardedBooksOfTheYear;

  bool isLoading = false;

  Future<void> getAwardedBooksOfTheYear(int year) async {
    isLoading = true;

    final response = await http.get(
      Uri.parse('https://hapi-books.p.rapidapi.com/top/$year'),
      headers: {
        'X-RapidAPI-Key': rapidAPIKey,
        'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> awardedBooksOfTheYearTemp = jsonDecode(response.body);

      _awardedBooksOfTheYear = awardedBooksOfTheYearTemp
          .map((dynamic item) => AwardedBooksOfTheYearModel.fromJson(item))
          .toList();
    } else {
      _awardedBooksOfTheYear = [];
    }
    statusCode = response.statusCode;
    isLoading = false;
    notifyListeners();
  }
}
