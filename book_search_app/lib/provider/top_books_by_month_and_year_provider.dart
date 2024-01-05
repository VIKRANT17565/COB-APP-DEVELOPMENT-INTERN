import 'dart:convert';

import 'package:book_search_app/globals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/top_books_by_month_and_year_model.dart';

class TopBooksByMonthAndYearProvider with ChangeNotifier {
  int statusCode = 0;
  List<TopBooksByMonthAndYearModel> _topBooksByMonthAndYear = [];

  List<TopBooksByMonthAndYearModel> get topBooksByMonthAndYear =>
      _topBooksByMonthAndYear;

  bool isLoading = false;

  Future<void> getTopBooksByMonthAndYear(int month, int year) async {
    isLoading = true;

    final response = await http.get(
      Uri.parse('https://hapi-books.p.rapidapi.com/month/$year/$month'),
      headers: {
        'X-RapidAPI-Key': rapidAPIKey,
        'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> topBooksByMonthAndYearTemp = jsonDecode(response.body);

      _topBooksByMonthAndYear = topBooksByMonthAndYearTemp
          .map((dynamic item) => TopBooksByMonthAndYearModel.fromJson(item))
          .toList();
    } else {
      _topBooksByMonthAndYear = [];
    }
    statusCode = response.statusCode;
    isLoading = false;
    notifyListeners();
  }
}
