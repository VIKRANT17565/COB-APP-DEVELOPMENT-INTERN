import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:book_search_app/globals.dart';
import 'package:book_search_app/provider/top_books_by_month_and_year_provider.dart';
import 'package:book_search_app/screens/book_info_screen_2nd.dart';
import 'package:book_search_app/screens/search_book_by_name.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TopBooksByMonthAndYear extends StatefulWidget {
  const TopBooksByMonthAndYear({super.key});

  @override
  State<TopBooksByMonthAndYear> createState() => _TopBooksByMonthAndYearState();
}

class _TopBooksByMonthAndYearState extends State<TopBooksByMonthAndYear> {
  String currentBookName = "";
  double currentBookRating = 0;
  bool showSearchBar = false;

  void updateBookInfo(int p0, int p1) {
    setState(() {
      currentBookName =
          Provider.of<TopBooksByMonthAndYearProvider>(context, listen: false)
              .topBooksByMonthAndYear[p1]
              .name;
      currentBookRating =
          Provider.of<TopBooksByMonthAndYearProvider>(context, listen: false)
              .topBooksByMonthAndYear[p1]
              .rating;
      roundOffRating();
    });
  }

  void roundOffRating() {
    setState(() {
      currentBookRating = (currentBookRating * 2).round() / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TopBooksByMonthAndYearProvider>(
      builder: (context, snapshot, child) {
        if (snapshot.statusCode == 0) {
          snapshot.getTopBooksByMonthAndYear(
              getCurrentMonth(), getCurrentYear());
        }

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            snapshot.statusCode == 429
                ? const Center(
                    child: Text(
                      "Too many requests. Please try again later.",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  )
                : snapshot.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : AnotherCarousel(
                        images: snapshot.topBooksByMonthAndYear
                            .map(
                              (e) => CachedNetworkImage(
                                imageUrl: e.cover,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            )
                            .toList(),
                        dotSize: 0,
                        dotBgColor: Colors.transparent,
                        onImageChange: (p0, p1) => updateBookInfo(p0, p1),
                        onImageTap: (p0) {
                          debugPrint("Image $p0 pressed");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BookInfoScreenOg(
                                  bookId: Provider.of<
                                              TopBooksByMonthAndYearProvider>(
                                          context)
                                      .topBooksByMonthAndYear[p0]
                                      .bookId,
                                  bookTitle: Provider.of<
                                              TopBooksByMonthAndYearProvider>(
                                          context)
                                      .topBooksByMonthAndYear[p0]
                                      .name,
                                  cover: Provider.of<
                                              TopBooksByMonthAndYearProvider>(
                                          context)
                                      .topBooksByMonthAndYear[p0]
                                      .cover,
                                  bookUrl: Provider.of<
                                              TopBooksByMonthAndYearProvider>(
                                          context)
                                      .topBooksByMonthAndYear[p0]
                                      .url,
                                );
                              },
                            ),
                          );
                        },
                        overlayShadowColors: Colors.black,
                      ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45 * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    ThemeData.dark().primaryColor,
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 60,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          debugPrint("Search button pressed");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SearchBookByName();
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 5,
                            ),
                          ],
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // height: 100,
                  padding: const EdgeInsets.all(10),
                  // color: Colors.pink,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        currentBookName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: currentBookRating,
                        minRating: currentBookRating,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 27,
                        unratedColor: Colors.black.withOpacity(0.5),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        maxRating: currentBookRating,
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
