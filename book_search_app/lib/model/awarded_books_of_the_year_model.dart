// To parse this JSON data, do
//
//     final awardedBooksOfTheYearModel = awardedBooksOfTheYearModelFromJson(jsonString);

import 'dart:convert';

List<AwardedBooksOfTheYearModel> awardedBooksOfTheYearModelFromJson(String str) => List<AwardedBooksOfTheYearModel>.from(json.decode(str).map((x) => AwardedBooksOfTheYearModel.fromJson(x)));

String awardedBooksOfTheYearModelToJson(List<AwardedBooksOfTheYearModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AwardedBooksOfTheYearModel {
    String bookId;
    String name;
    String category;
    String cover;
    String url;

    AwardedBooksOfTheYearModel({
        required this.bookId,
        required this.name,
        required this.category,
        required this.cover,
        required this.url,
    });

    factory AwardedBooksOfTheYearModel.fromJson(Map<String, dynamic> json) => AwardedBooksOfTheYearModel(
        bookId: json["book_id"],
        name: json["name"],
        category: json["category"],
        cover: json["cover"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "name": name,
        "category": category,
        "cover": cover,
        "url": url,
    };
}
