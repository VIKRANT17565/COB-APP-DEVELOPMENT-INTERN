// To parse this JSON data, do
//
//     final topBooksByMonthAndYearModel = topBooksByMonthAndYearModelFromJson(jsonString);

import 'dart:convert';

List<TopBooksByMonthAndYearModel> topBooksByMonthAndYearModelFromJson(String str) => List<TopBooksByMonthAndYearModel>.from(json.decode(str).map((x) => TopBooksByMonthAndYearModel.fromJson(x)));

String topBooksByMonthAndYearModelToJson(List<TopBooksByMonthAndYearModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopBooksByMonthAndYearModel {
    String bookId;
    String position;
    String name;
    String cover;
    double rating;
    String url;

    TopBooksByMonthAndYearModel({
        required this.bookId,
        required this.position,
        required this.name,
        required this.cover,
        required this.rating,
        required this.url,
    });

    factory TopBooksByMonthAndYearModel.fromJson(Map<String, dynamic> json) => TopBooksByMonthAndYearModel(
        bookId: json["book_id"],
        position: json["position"],
        name: json["name"],
        cover: json["cover"],
        rating: json["rating"]?.toDouble(),
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "position": position,
        "name": name,
        "cover": cover,
        "rating": rating,
        "url": url,
    };
}
