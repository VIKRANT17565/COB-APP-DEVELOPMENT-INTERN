// To parse this JSON data, do
//
//     final searchBookByNameModel = searchBookByNameModelFromJson(jsonString);

import 'dart:convert';

SearchBookByNameModel searchBookByNameModelFromJson(String str) => SearchBookByNameModel.fromJson(json.decode(str));

String searchBookByNameModelToJson(SearchBookByNameModel data) => json.encode(data.toJson());

class SearchBookByNameModel {
    final String kind;
    final int totalItems;
    final List<Item> items;

    SearchBookByNameModel({
        required this.kind,
        required this.totalItems,
        required this.items,
    });

    factory SearchBookByNameModel.fromJson(Map<String, dynamic> json) => SearchBookByNameModel(
        kind: json["kind"],
        totalItems: json["totalItems"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    final ItemKind kind;
    final String id;
    final String etag;
    final String selfLink;
    final VolumeInfo volumeInfo;
    final SaleInfo saleInfo;
    final AccessInfo accessInfo;
    final SearchInfo? searchInfo;

    Item({
        required this.kind,
        required this.id,
        required this.etag,
        required this.selfLink,
        required this.volumeInfo,
        required this.saleInfo,
        required this.accessInfo,
        this.searchInfo,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: itemKindValues.map[json["kind"]]!,
        id: json["id"],
        etag: json["etag"],
        selfLink: json["selfLink"],
        volumeInfo: VolumeInfo.fromJson(json["volumeInfo"]),
        saleInfo: SaleInfo.fromJson(json["saleInfo"]),
        accessInfo: AccessInfo.fromJson(json["accessInfo"]),
        searchInfo: json["searchInfo"] == null ? null : SearchInfo.fromJson(json["searchInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "kind": itemKindValues.reverse[kind],
        "id": id,
        "etag": etag,
        "selfLink": selfLink,
        "volumeInfo": volumeInfo.toJson(),
        "saleInfo": saleInfo.toJson(),
        "accessInfo": accessInfo.toJson(),
        "searchInfo": searchInfo?.toJson(),
    };
}

class AccessInfo {
    final Country country;
    final Viewability viewability;
    final bool embeddable;
    final bool publicDomain;
    final TextToSpeechPermission textToSpeechPermission;
    final Epub epub;
    final Epub pdf;
    final String webReaderLink;
    final AccessViewStatus accessViewStatus;
    final bool quoteSharingAllowed;

    AccessInfo({
        required this.country,
        required this.viewability,
        required this.embeddable,
        required this.publicDomain,
        required this.textToSpeechPermission,
        required this.epub,
        required this.pdf,
        required this.webReaderLink,
        required this.accessViewStatus,
        required this.quoteSharingAllowed,
    });

    factory AccessInfo.fromJson(Map<String, dynamic> json) => AccessInfo(
        country: countryValues.map[json["country"]]!,
        viewability: viewabilityValues.map[json["viewability"]]!,
        embeddable: json["embeddable"],
        publicDomain: json["publicDomain"],
        textToSpeechPermission: textToSpeechPermissionValues.map[json["textToSpeechPermission"]]!,
        epub: Epub.fromJson(json["epub"]),
        pdf: Epub.fromJson(json["pdf"]),
        webReaderLink: json["webReaderLink"],
        accessViewStatus: accessViewStatusValues.map[json["accessViewStatus"]]!,
        quoteSharingAllowed: json["quoteSharingAllowed"],
    );

    Map<String, dynamic> toJson() => {
        "country": countryValues.reverse[country],
        "viewability": viewabilityValues.reverse[viewability],
        "embeddable": embeddable,
        "publicDomain": publicDomain,
        "textToSpeechPermission": textToSpeechPermissionValues.reverse[textToSpeechPermission],
        "epub": epub.toJson(),
        "pdf": pdf.toJson(),
        "webReaderLink": webReaderLink,
        "accessViewStatus": accessViewStatusValues.reverse[accessViewStatus],
        "quoteSharingAllowed": quoteSharingAllowed,
    };
}

enum AccessViewStatus {
    FULL_PUBLIC_DOMAIN,
    NONE,
    SAMPLE
}

final accessViewStatusValues = EnumValues({
    "FULL_PUBLIC_DOMAIN": AccessViewStatus.FULL_PUBLIC_DOMAIN,
    "NONE": AccessViewStatus.NONE,
    "SAMPLE": AccessViewStatus.SAMPLE
});

enum Country {
    IN
}

final countryValues = EnumValues({
    "IN": Country.IN
});

class Epub {
    final bool isAvailable;
    final String? acsTokenLink;
    final String? downloadLink;

    Epub({
        required this.isAvailable,
        this.acsTokenLink,
        this.downloadLink,
    });

    factory Epub.fromJson(Map<String, dynamic> json) => Epub(
        isAvailable: json["isAvailable"],
        acsTokenLink: json["acsTokenLink"],
        downloadLink: json["downloadLink"],
    );

    Map<String, dynamic> toJson() => {
        "isAvailable": isAvailable,
        "acsTokenLink": acsTokenLink,
        "downloadLink": downloadLink,
    };
}

enum TextToSpeechPermission {
    ALLOWED,
    ALLOWED_FOR_ACCESSIBILITY
}

final textToSpeechPermissionValues = EnumValues({
    "ALLOWED": TextToSpeechPermission.ALLOWED,
    "ALLOWED_FOR_ACCESSIBILITY": TextToSpeechPermission.ALLOWED_FOR_ACCESSIBILITY
});

enum Viewability {
    ALL_PAGES,
    NO_PAGES,
    PARTIAL
}

final viewabilityValues = EnumValues({
    "ALL_PAGES": Viewability.ALL_PAGES,
    "NO_PAGES": Viewability.NO_PAGES,
    "PARTIAL": Viewability.PARTIAL
});

enum ItemKind {
    BOOKS_VOLUME
}

final itemKindValues = EnumValues({
    "books#volume": ItemKind.BOOKS_VOLUME
});

class SaleInfo {
    final Country country;
    final Saleability saleability;
    final bool isEbook;
    final SaleInfoListPrice? listPrice;
    final SaleInfoListPrice? retailPrice;
    final String? buyLink;
    final List<Offer>? offers;

    SaleInfo({
        required this.country,
        required this.saleability,
        required this.isEbook,
        this.listPrice,
        this.retailPrice,
        this.buyLink,
        this.offers,
    });

    factory SaleInfo.fromJson(Map<String, dynamic> json) => SaleInfo(
        country: countryValues.map[json["country"]]!,
        saleability: saleabilityValues.map[json["saleability"]]!,
        isEbook: json["isEbook"],
        listPrice: json["listPrice"] == null ? null : SaleInfoListPrice.fromJson(json["listPrice"]),
        retailPrice: json["retailPrice"] == null ? null : SaleInfoListPrice.fromJson(json["retailPrice"]),
        buyLink: json["buyLink"],
        offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "country": countryValues.reverse[country],
        "saleability": saleabilityValues.reverse[saleability],
        "isEbook": isEbook,
        "listPrice": listPrice?.toJson(),
        "retailPrice": retailPrice?.toJson(),
        "buyLink": buyLink,
        "offers": offers == null ? [] : List<dynamic>.from(offers!.map((x) => x.toJson())),
    };
}

class SaleInfoListPrice {
    final double amount;
    final CurrencyCode currencyCode;

    SaleInfoListPrice({
        required this.amount,
        required this.currencyCode,
    });

    factory SaleInfoListPrice.fromJson(Map<String, dynamic> json) => SaleInfoListPrice(
        amount: json["amount"]?.toDouble(),
        currencyCode: currencyCodeValues.map[json["currencyCode"]]!,
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "currencyCode": currencyCodeValues.reverse[currencyCode],
    };
}

enum CurrencyCode {
    INR
}

final currencyCodeValues = EnumValues({
    "INR": CurrencyCode.INR
});

class Offer {
    final int finskyOfferType;
    final OfferListPrice listPrice;
    final OfferListPrice retailPrice;

    Offer({
        required this.finskyOfferType,
        required this.listPrice,
        required this.retailPrice,
    });

    factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        finskyOfferType: json["finskyOfferType"],
        listPrice: OfferListPrice.fromJson(json["listPrice"]),
        retailPrice: OfferListPrice.fromJson(json["retailPrice"]),
    );

    Map<String, dynamic> toJson() => {
        "finskyOfferType": finskyOfferType,
        "listPrice": listPrice.toJson(),
        "retailPrice": retailPrice.toJson(),
    };
}

class OfferListPrice {
    final int amountInMicros;
    final CurrencyCode currencyCode;

    OfferListPrice({
        required this.amountInMicros,
        required this.currencyCode,
    });

    factory OfferListPrice.fromJson(Map<String, dynamic> json) => OfferListPrice(
        amountInMicros: json["amountInMicros"],
        currencyCode: currencyCodeValues.map[json["currencyCode"]]!,
    );

    Map<String, dynamic> toJson() => {
        "amountInMicros": amountInMicros,
        "currencyCode": currencyCodeValues.reverse[currencyCode],
    };
}

enum Saleability {
    FOR_SALE,
    FREE,
    NOT_FOR_SALE
}

final saleabilityValues = EnumValues({
    "FOR_SALE": Saleability.FOR_SALE,
    "FREE": Saleability.FREE,
    "NOT_FOR_SALE": Saleability.NOT_FOR_SALE
});

class SearchInfo {
    final String textSnippet;

    SearchInfo({
        required this.textSnippet,
    });

    factory SearchInfo.fromJson(Map<String, dynamic> json) => SearchInfo(
        textSnippet: json["textSnippet"],
    );

    Map<String, dynamic> toJson() => {
        "textSnippet": textSnippet,
    };
}

class VolumeInfo {
    final String title;
    final String? subtitle;
    final List<String>? authors;
    final String? publisher;
    final String? publishedDate;
    final String? description;
    final List<IndustryIdentifier>? industryIdentifiers;
    final ReadingModes readingModes;
    final int? pageCount;
    final PrintType printType;
    final List<String>? categories;
    final double? averageRating;
    final int? ratingsCount;
    final MaturityRating maturityRating;
    final bool allowAnonLogging;
    final String contentVersion;
    final PanelizationSummary? panelizationSummary;
    final ImageLinks? imageLinks;
    final Language language;
    final String previewLink;
    final String infoLink;
    final String canonicalVolumeLink;
    final SeriesInfo? seriesInfo;
    final bool? comicsContent;

    VolumeInfo({
        required this.title,
        this.subtitle,
        this.authors,
        this.publisher,
        this.publishedDate,
        this.description,
        this.industryIdentifiers,
        required this.readingModes,
        this.pageCount,
        required this.printType,
        this.categories,
        this.averageRating,
        this.ratingsCount,
        required this.maturityRating,
        required this.allowAnonLogging,
        required this.contentVersion,
        this.panelizationSummary,
        this.imageLinks,
        required this.language,
        required this.previewLink,
        required this.infoLink,
        required this.canonicalVolumeLink,
        this.seriesInfo,
        this.comicsContent,
    });

    factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        title: json["title"],
        subtitle: json["subtitle"],
        authors: json["authors"] == null ? [] : List<String>.from(json["authors"]!.map((x) => x)),
        publisher: json["publisher"],
        publishedDate: json["publishedDate"],
        description: json["description"],
        industryIdentifiers: json["industryIdentifiers"] == null ? [] : List<IndustryIdentifier>.from(json["industryIdentifiers"]!.map((x) => IndustryIdentifier.fromJson(x))),
        readingModes: ReadingModes.fromJson(json["readingModes"]),
        pageCount: json["pageCount"],
        printType: printTypeValues.map[json["printType"]]!,
        categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
        averageRating: json["averageRating"]?.toDouble(),
        ratingsCount: json["ratingsCount"],
        maturityRating: maturityRatingValues.map[json["maturityRating"]]!,
        allowAnonLogging: json["allowAnonLogging"],
        contentVersion: json["contentVersion"],
        panelizationSummary: json["panelizationSummary"] == null ? null : PanelizationSummary.fromJson(json["panelizationSummary"]),
        imageLinks: json["imageLinks"] == null ? null : ImageLinks.fromJson(json["imageLinks"]),
        language: languageValues.map[json["language"]]!,
        previewLink: json["previewLink"],
        infoLink: json["infoLink"],
        canonicalVolumeLink: json["canonicalVolumeLink"],
        seriesInfo: json["seriesInfo"] == null ? null : SeriesInfo.fromJson(json["seriesInfo"]),
        comicsContent: json["comicsContent"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "authors": authors == null ? [] : List<dynamic>.from(authors!.map((x) => x)),
        "publisher": publisher,
        "publishedDate": publishedDate,
        "description": description,
        "industryIdentifiers": industryIdentifiers == null ? [] : List<dynamic>.from(industryIdentifiers!.map((x) => x.toJson())),
        "readingModes": readingModes.toJson(),
        "pageCount": pageCount,
        "printType": printTypeValues.reverse[printType],
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
        "averageRating": averageRating,
        "ratingsCount": ratingsCount,
        "maturityRating": maturityRatingValues.reverse[maturityRating],
        "allowAnonLogging": allowAnonLogging,
        "contentVersion": contentVersion,
        "panelizationSummary": panelizationSummary?.toJson(),
        "imageLinks": imageLinks?.toJson(),
        "language": languageValues.reverse[language],
        "previewLink": previewLink,
        "infoLink": infoLink,
        "canonicalVolumeLink": canonicalVolumeLink,
        "seriesInfo": seriesInfo?.toJson(),
        "comicsContent": comicsContent,
    };
}

class ImageLinks {
    final String smallThumbnail;
    final String thumbnail;

    ImageLinks({
        required this.smallThumbnail,
        required this.thumbnail,
    });

    factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json["smallThumbnail"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail,
        "thumbnail": thumbnail,
    };
}

class IndustryIdentifier {
    final Type type;
    final String identifier;

    IndustryIdentifier({
        required this.type,
        required this.identifier,
    });

    factory IndustryIdentifier.fromJson(Map<String, dynamic> json) => IndustryIdentifier(
        type: typeValues.map[json["type"]]!,
        identifier: json["identifier"],
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "identifier": identifier,
    };
}

enum Type {
    ISBN_10,
    ISBN_13,
    OTHER
}

final typeValues = EnumValues({
    "ISBN_10": Type.ISBN_10,
    "ISBN_13": Type.ISBN_13,
    "OTHER": Type.OTHER
});

enum Language {
    EN,
    FR,
    ID,
    IT,
    TA
}

final languageValues = EnumValues({
    "en": Language.EN,
    "fr": Language.FR,
    "id": Language.ID,
    "it": Language.IT,
    "ta": Language.TA
});

enum MaturityRating {
    MATURE,
    NOT_MATURE
}

final maturityRatingValues = EnumValues({
    "MATURE": MaturityRating.MATURE,
    "NOT_MATURE": MaturityRating.NOT_MATURE
});

class PanelizationSummary {
    final bool containsEpubBubbles;
    final bool containsImageBubbles;
    final String? epubBubbleVersion;
    final String? imageBubbleVersion;

    PanelizationSummary({
        required this.containsEpubBubbles,
        required this.containsImageBubbles,
        this.epubBubbleVersion,
        this.imageBubbleVersion,
    });

    factory PanelizationSummary.fromJson(Map<String, dynamic> json) => PanelizationSummary(
        containsEpubBubbles: json["containsEpubBubbles"],
        containsImageBubbles: json["containsImageBubbles"],
        epubBubbleVersion: json["epubBubbleVersion"],
        imageBubbleVersion: json["imageBubbleVersion"],
    );

    Map<String, dynamic> toJson() => {
        "containsEpubBubbles": containsEpubBubbles,
        "containsImageBubbles": containsImageBubbles,
        "epubBubbleVersion": epubBubbleVersion,
        "imageBubbleVersion": imageBubbleVersion,
    };
}

enum PrintType {
    BOOK
}

final printTypeValues = EnumValues({
    "BOOK": PrintType.BOOK
});

class ReadingModes {
    final bool text;
    final bool image;

    ReadingModes({
        required this.text,
        required this.image,
    });

    factory ReadingModes.fromJson(Map<String, dynamic> json) => ReadingModes(
        text: json["text"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "image": image,
    };
}

class SeriesInfo {
    final SeriesInfoKind kind;
    final String? shortSeriesBookTitle;
    final String bookDisplayNumber;
    final List<VolumeSery> volumeSeries;

    SeriesInfo({
        required this.kind,
        this.shortSeriesBookTitle,
        required this.bookDisplayNumber,
        required this.volumeSeries,
    });

    factory SeriesInfo.fromJson(Map<String, dynamic> json) => SeriesInfo(
        kind: seriesInfoKindValues.map[json["kind"]]!,
        shortSeriesBookTitle: json["shortSeriesBookTitle"],
        bookDisplayNumber: json["bookDisplayNumber"],
        volumeSeries: List<VolumeSery>.from(json["volumeSeries"].map((x) => VolumeSery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "kind": seriesInfoKindValues.reverse[kind],
        "shortSeriesBookTitle": shortSeriesBookTitle,
        "bookDisplayNumber": bookDisplayNumber,
        "volumeSeries": List<dynamic>.from(volumeSeries.map((x) => x.toJson())),
    };
}

enum SeriesInfoKind {
    BOOKS_VOLUME_SERIES_INFO
}

final seriesInfoKindValues = EnumValues({
    "books#volume_series_info": SeriesInfoKind.BOOKS_VOLUME_SERIES_INFO
});

class VolumeSery {
    final String seriesId;
    final SeriesBookType seriesBookType;
    final int orderNumber;

    VolumeSery({
        required this.seriesId,
        required this.seriesBookType,
        required this.orderNumber,
    });

    factory VolumeSery.fromJson(Map<String, dynamic> json) => VolumeSery(
        seriesId: json["seriesId"],
        seriesBookType: seriesBookTypeValues.map[json["seriesBookType"]]!,
        orderNumber: json["orderNumber"],
    );

    Map<String, dynamic> toJson() => {
        "seriesId": seriesId,
        "seriesBookType": seriesBookTypeValues.reverse[seriesBookType],
        "orderNumber": orderNumber,
    };
}

enum SeriesBookType {
    COLLECTED_EDITION,
    ISSUE
}

final seriesBookTypeValues = EnumValues({
    "COLLECTED_EDITION": SeriesBookType.COLLECTED_EDITION,
    "ISSUE": SeriesBookType.ISSUE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
