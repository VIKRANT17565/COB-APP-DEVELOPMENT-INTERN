import 'dart:convert';

import 'package:book_search_app/globals.dart';
import 'package:book_search_app/model/book_information_by_book_id_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookInformationByBookIdProvider with ChangeNotifier {
  int statusCode = 0;
  Map<String, BookInformationByBookIdModel> _bookInformationByBookId = {};
  Map<String, BookInformationByBookIdModel> get bookInformationByBookId =>
      _bookInformationByBookId;

  bool isLoading = false;

  Future<void> getBookInformationByBookId(String bookId) async {
    isLoading = true;

    final response = await http.get(
      Uri.parse('https://hapi-books.p.rapidapi.com/book/$bookId'),
      headers: {
        'X-RapidAPI-Key': rapidAPIKey,
        'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com'
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      statusCode = response.statusCode;
      Map<String, dynamic> bookInformationByBookIdTemp =
          jsonDecode(response.body);

      _bookInformationByBookId[bookId] =
          BookInformationByBookIdModel.fromJson(bookInformationByBookIdTemp);
    } else {
      _bookInformationByBookId = {};
    }
    isLoading = false;

    notifyListeners();
    statusCode = 0;
  }
}
