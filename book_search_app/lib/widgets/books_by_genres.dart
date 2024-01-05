import 'dart:math';

import 'package:book_search_app/globals.dart';
import 'package:book_search_app/provider/books_by_genres_provider.dart';
import 'package:book_search_app/screens/book_info_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksByGenres extends StatefulWidget {
  const BooksByGenres({super.key});

  @override
  State<BooksByGenres> createState() => _BooksByGenresState();
}

class _BooksByGenresState extends State<BooksByGenres> {
  String selectedGenre = genres[Random().nextInt(genres.length)];
  List<DropdownMenuItem<String>> dropdownItems = [];

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String genre in genres) {
      var newItem = DropdownMenuItem(
        value: genre,
        child: Text(genre),
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BooksByGenresProvider>(
      builder: (context, snapshot, child) {
        if (snapshot.statusCode == 0) {
          snapshot.getBooksByGenres(selectedGenre);
        }

        return Container(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      "Books by Genres",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: selectedGenre,
                      padding: const EdgeInsets.only(right: 5),
                      alignment: Alignment.centerRight,
                      underline: const SizedBox.shrink(),
                      icon: const SizedBox.shrink(),
                      items: getDropDownItems(),
                      onChanged: (Object? value) {
                        setState(() {
                          selectedGenre = value as String;
                          if (snapshot.booksByGenres[selectedGenre] == null) {
                            snapshot.getBooksByGenres(selectedGenre);
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(5),
                      menuMaxHeight: 200,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.booksByGenres[selectedGenre]?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width:
                          (MediaQuery.of(context).size.width - 2 * 3) * 1 / 3,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Center(
                              child: snapshot.statusCode != 200
                                  ? Center(
                                      child: snapshot.statusCode == 429
                                          ? Center(
                                              child: Text(
                                                "Error 429\nToo many requests, please try again later, $index",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : const CircularProgressIndicator(),
                                    )
                                  : snapshot.booksByGenres[selectedGenre] !=
                                          null
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BookInfoScreen(
                                                  cover: snapshot
                                                      .booksByGenres[
                                                          selectedGenre]![index]
                                                      .cover,
                                                  bookTitle: snapshot
                                                      .booksByGenres[
                                                          selectedGenre]![index]
                                                      .title,
                                                  bookAuthor:
                                                      '${snapshot.booksByGenres[selectedGenre]![index].author.firstName} ${snapshot.booksByGenres[selectedGenre]![index].author.lastName}',
                                                  bookDescription: snapshot
                                                      .booksByGenres[
                                                          selectedGenre]![index]
                                                      .plot,
                                                  bookRating: snapshot
                                                      .booksByGenres[
                                                          selectedGenre]![index]
                                                      .rating
                                                      .toString(),
                                                  bookPages: snapshot
                                                      .booksByGenres[
                                                          selectedGenre]![index]
                                                      .pages
                                                      .toString(),
                                                  bookGenres: snapshot
                                                      .booksByGenres[
                                                          selectedGenre]![index]
                                                      .genres,
                                                ),
                                              ),
                                            );
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot
                                                .booksByGenres[selectedGenre]![
                                                    index]
                                                .cover,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
