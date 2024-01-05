import 'package:book_search_app/provider/awarded_books_of_the_year_provider.dart';
import 'package:book_search_app/provider/book_information_by_book_id_provider.dart';
import 'package:book_search_app/provider/books_by_genres_provider.dart';
import 'package:book_search_app/provider/weekly_popular_books_by_genre_provider.dart';
import 'package:book_search_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/top_books_by_month_and_year_provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeeklyPopularBooksByGenreProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopBooksByMonthAndYearProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AwardedBooksOfTheYearProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BooksByGenresProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookInformationByBookIdProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
