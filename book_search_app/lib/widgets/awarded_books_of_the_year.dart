import 'package:book_search_app/globals.dart';
import 'package:book_search_app/provider/awarded_books_of_the_year_provider.dart';
import 'package:book_search_app/screens/book_info_screen_2nd.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AwardedBooksOfTheYear extends StatefulWidget {
  const AwardedBooksOfTheYear({super.key});

  @override
  State<AwardedBooksOfTheYear> createState() => _AwardedBooksOfTheYearState();
}

class _AwardedBooksOfTheYearState extends State<AwardedBooksOfTheYear> {
  String selectedGenre = genres[0];
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
    return Consumer<AwardedBooksOfTheYearProvider>(
      builder: (context, snapshot, child) {
        if (snapshot.statusCode == 0) {
          snapshot.getAwardedBooksOfTheYear(getCurrentYear() - 1);
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
                    Text(
                      "Awarded Books of ${getCurrentYear() - 1}",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.awardedBooksOfTheYear.isEmpty
                      ? 10
                      : snapshot.awardedBooksOfTheYear.length,
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
                                  : snapshot.awardedBooksOfTheYear.isNotEmpty
                                      ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookInfoScreenOg(
                                                bookId: snapshot
                                                    .awardedBooksOfTheYear[
                                                        index]
                                                    .bookId
                                                    .toString(),
                                                bookTitle: snapshot
                                                    .awardedBooksOfTheYear[
                                                        index]
                                                    .name,
                                                cover: snapshot
                                                    .awardedBooksOfTheYear[
                                                        index]
                                                    .cover,
                                                bookUrl: snapshot
                                                    .awardedBooksOfTheYear[
                                                        index]
                                                    .url,
                                              ),
                                            ),
                                          );
                                        },
                                        child: CachedNetworkImage(
                                            imageUrl: snapshot
                                                .awardedBooksOfTheYear[index]
                                                .cover,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget: (context, url, error) =>
                                                const Icon(Icons.error),
                                          ),
                                      )
                                      : const Center(
                                          child: Text(
                                            "No books found",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
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
