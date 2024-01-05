import 'dart:convert';

import 'package:book_search_app/globals.dart';
import 'package:book_search_app/model/book_information_by_book_id_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class BookInfoScreenOg extends StatefulWidget {
  final String bookId;
  final String bookTitle;
  final String cover;
  final String bookUrl;
  const BookInfoScreenOg({
    super.key,
    required this.bookId,
    required this.bookTitle,
    required this.cover,
    required this.bookUrl,
  });

  @override
  State<BookInfoScreenOg> createState() => _BookInfoScreenOgState();
}

class _BookInfoScreenOgState extends State<BookInfoScreenOg> {
  bool isLoading = false;

  late BookInformationByBookIdModel bookInfo;
  late String bookAuthor;
  late String bookPages;
  late String bookDescription;
  late String bookRating;
  late List<String> bookGenres;

  Future<void> getBookInfoById(String id) async {
    isLoading = true;
    final response = await http.get(
      Uri.parse('https://hapi-books.p.rapidapi.com/book/$id'),
      headers: {
        'X-RapidAPI-Key': rapidAPIKey,
        'X-RapidAPI-Host': 'hapi-books.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> bookInfoTemp = jsonDecode(response.body);

      bookInfo = BookInformationByBookIdModel.fromJson(bookInfoTemp);

      bookAuthor = bookInfo.authors.join(', ');
      bookPages = bookInfo.pages.toString();
      bookDescription = bookInfo.synopsis;
      bookRating = bookInfo.rating.toString();
      bookGenres = [];
      searchedBookInfoById[id] = bookInfo;

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load book info');
    }
  }

  @override
  void initState() {
    if (searchedBookInfoById.containsKey(widget.bookId)) {
      bookInfo = searchedBookInfoById[widget.bookId];
      bookAuthor = bookInfo.authors.join(', ');
      bookPages = bookInfo.pages.toString();
      bookDescription = bookInfo.synopsis;
      bookGenres = [];
    } else {
      getBookInfoById(widget.bookId);
      setState(() {
        isLoading;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Information'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                color: Colors.grey[900],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: widget.cover,
                            // width: double.infinity,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.bookTitle,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Author: $bookAuthor',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Rating: $bookRating',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Pages: $bookPages',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            bookGenres.join(', '),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Description:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            bookDescription,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
