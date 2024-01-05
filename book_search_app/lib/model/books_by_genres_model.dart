// To parse this JSON data, do
//
//     final booksByGenresModel = booksByGenresModelFromJson(jsonString);

import 'dart:convert';

List<BooksByGenresModel> booksByGenresModelFromJson(String str) => List<BooksByGenresModel>.from(json.decode(str).map((x) => BooksByGenresModel.fromJson(x)));

String booksByGenresModelToJson(List<BooksByGenresModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BooksByGenresModel {
    Author author;
    String id;
    int bookId;
    String title;
    int pages;
    List<String> genres;
    Review? reviews;
    String cover;
    String url;
    String plot;
    double rating;
    Review? review;
    int? v;

    BooksByGenresModel({
        required this.author,
        required this.id,
        required this.bookId,
        required this.title,
        required this.pages,
        required this.genres,
        this.reviews,
        required this.cover,
        required this.url,
        required this.plot,
        required this.rating,
        this.review,
        this.v,
    });

    factory BooksByGenresModel.fromJson(Map<String, dynamic> json) => BooksByGenresModel(
        author: Author.fromJson(json["author"]),
        id: json["_id"],
        bookId: json["book_id"],
        title: json["title"],
        pages: json["pages"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        reviews: json["reviews"] == null ? null : Review.fromJson(json["reviews"]),
        cover: json["cover"],
        url: json["url"],
        plot: json["plot"],
        rating: json["rating"]?.toDouble(),
        review: json["review"] == null ? null : Review.fromJson(json["review"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "_id": id,
        "book_id": bookId,
        "title": title,
        "pages": pages,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "reviews": reviews?.toJson(),
        "cover": cover,
        "url": url,
        "plot": plot,
        "rating": rating,
        "review": review?.toJson(),
        "__v": v,
    };
}

class Author {
    String firstName;
    String lastName;

    Author({
        required this.firstName,
        required this.lastName,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        firstName: json["first_name"],
        lastName: json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
    };
}

class Review {
    String name;
    String body;

    Review({
        required this.name,
        required this.body,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "body": body,
    };
}
