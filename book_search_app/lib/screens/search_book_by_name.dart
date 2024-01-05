import 'dart:convert';

import 'package:book_search_app/model/search_book_by_name_model.dart';
import 'package:book_search_app/screens/book_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_search_app/widgets/custom_list_tile.dart';
import 'package:http/http.dart' as http;

class SearchBookByName extends StatefulWidget {
  const SearchBookByName({super.key});

  @override
  State<SearchBookByName> createState() => SsearchedBookByNameState();
}

class SsearchedBookByNameState extends State<SearchBookByName> {
  final TextEditingController _searchController = TextEditingController();
  bool isLoaded = false;
  bool error = false;
  late SearchBookByNameModel _searchedBooks;
  List _searchedBooksItems = [];

  Future<void> _searchBooks(String searchTerm) async {
    setState(() {
      isLoaded = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://www.googleapis.com/books/v1/volumes?q={$searchTerm}'),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> searchedBooksTemp = jsonDecode(response.body);
        _searchedBooks = SearchBookByNameModel.fromJson(searchedBooksTemp);
        _searchedBooksItems = _searchedBooks.items;
      }
    } catch (e) {
      setState(() {
        error = true;
      });
    }

    setState(() {
      isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books by Name'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: _searchBooks,
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: isLoaded
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _searchedBooksItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BookInfoScreen(
                                  cover: _searchedBooksItems[index]
                                          .volumeInfo
                                          .imageLinks
                                          ?.thumbnail ??
                                      "https://via.placeholder.com/150",
                                  bookTitle: _searchedBooksItems[index]
                                      .volumeInfo
                                      .title,
                                  bookAuthor: _searchedBooksItems[index]
                                      .volumeInfo
                                      .authors
                                      .join(", "),
                                  bookDescription: _searchedBooksItems[index]
                                      .volumeInfo
                                      .description,
                                  bookRating: _searchedBooksItems[index]
                                      .volumeInfo
                                      .averageRating
                                      .toString(),
                                  bookPages: _searchedBooksItems[index]
                                      .volumeInfo
                                      .pageCount
                                      .toString(),
                                  bookGenres: _searchedBooksItems[index]
                                      .volumeInfo
                                      .categories,
                                );
                              },
                            ),
                          );
                        },
                        child: error
                            ? const Center(
                                child: Text(
                                  "Something went wrong!\nPlease try again later.",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            : CustomListTile(
                                bookName:
                                    _searchedBooksItems[index].volumeInfo.title,
                                bookAuthor: _searchedBooksItems[index]
                                    .volumeInfo
                                    .authors
                                    .join(", "),
                                bookImage: _searchedBooksItems[index]
                                        .volumeInfo
                                        .imageLinks
                                        ?.thumbnail ??
                                    "https://via.placeholder.com/150",
                              ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
