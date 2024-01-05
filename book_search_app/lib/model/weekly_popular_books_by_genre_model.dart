// To parse this JSON data, do
//
//     final weeklyPopularBooksByGenreModel = weeklyPopularBooksByGenreModelFromJson(jsonString);

import 'dart:convert';

List<WeeklyPopularBooksByGenreModel> weeklyPopularBooksByGenreModelFromJson(String str) => List<WeeklyPopularBooksByGenreModel>.from(json.decode(str).map((x) => WeeklyPopularBooksByGenreModel.fromJson(x)));

String weeklyPopularBooksByGenreModelToJson(List<WeeklyPopularBooksByGenreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeeklyPopularBooksByGenreModel {
    int bookId;
    String name;
    String cover;
    String url;

    WeeklyPopularBooksByGenreModel({
        required this.bookId,
        required this.name,
        required this.cover,
        required this.url,
    });

    WeeklyPopularBooksByGenreModel copyWith({
        int? bookId,
        String? name,
        String? cover,
        String? url,
    }) => 
        WeeklyPopularBooksByGenreModel(
            bookId: bookId ?? this.bookId,
            name: name ?? this.name,
            cover: cover ?? this.cover,
            url: url ?? this.url,
        );

    factory WeeklyPopularBooksByGenreModel.fromJson(Map<String, dynamic> json) => WeeklyPopularBooksByGenreModel(
        bookId: json["book_id"],
        name: json["name"],
        cover: json["cover"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "name": name,
        "cover": cover,
        "url": url,
    };
}
