// To parse this JSON data, do
//
//     final bookInformationByBookIdModel = bookInformationByBookIdModelFromJson(jsonString);

import 'dart:convert';

BookInformationByBookIdModel bookInformationByBookIdModelFromJson(String str) => BookInformationByBookIdModel.fromJson(json.decode(str));

String bookInformationByBookIdModelToJson(BookInformationByBookIdModel data) => json.encode(data.toJson());

class BookInformationByBookIdModel {
    int bookId;
    String name;
    String cover;
    String url;
    List<String> authors;
    double rating;
    int pages;
    String publishedDate;
    String synopsis;

    BookInformationByBookIdModel({
        required this.bookId,
        required this.name,
        required this.cover,
        required this.url,
        required this.authors,
        required this.rating,
        required this.pages,
        required this.publishedDate,
        required this.synopsis,
    });

    factory BookInformationByBookIdModel.fromJson(Map<String, dynamic> json) => BookInformationByBookIdModel(
        bookId: json["book_id"],
        name: json["name"],
        cover: json["cover"],
        url: json["url"],
        authors: List<String>.from(json["authors"].map((x) => x)),
        rating: json["rating"]?.toDouble(),
        pages: json["pages"],
        publishedDate: json["published_date"],
        synopsis: json["synopsis"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "name": name,
        "cover": cover,
        "url": url,
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "rating": rating,
        "pages": pages,
        "published_date": publishedDate,
        "synopsis": synopsis,
    };
}
