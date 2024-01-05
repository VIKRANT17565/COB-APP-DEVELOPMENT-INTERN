import 'package:book_search_app/widgets/awarded_books_of_the_year.dart';
import 'package:book_search_app/widgets/books_by_genres.dart';
import 'package:book_search_app/widgets/top_books_by_month_and_year.dart';
import 'package:book_search_app/widgets/weekly_popular_books_by_genre.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: const TopBooksByMonthAndYear(),
            ),
            Container(
              height: 260,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const WeeklyPopularBooksByGenre(),
            ),
            Container(
              height: 260,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const AwardedBooksOfTheYear(),
            ),
            Container(
              height: 260,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const BooksByGenres(),
            ),
          ],
        ),
      ),
    );
  }
}
