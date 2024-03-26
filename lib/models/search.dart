// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  final List<Business> businesses;

  Search({
    required this.businesses,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        businesses: List<Business>.from(
            json["businesses"].map((x) => Business.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "businesses": List<dynamic>.from(businesses.map((x) => x.toJson())),
      };
}

class Business {
  final String id;
  final String alias;
  final String name;
  final String imageUrl;
  final bool isClosed;
  final String url;
  final int reviewCount;
  final List<Category> categories;
  final double rating;
  final List<dynamic> transactions;
  final Location location;
  final String phone;
  final String displayPhone;
  final double distance;
  final Attributes attributes;

  Business({
    required this.id,
    required this.alias,
    required this.name,
    required this.imageUrl,
    required this.isClosed,
    required this.url,
    required this.reviewCount,
    required this.categories,
    required this.rating,
    required this.transactions,
    required this.location,
    required this.phone,
    required this.displayPhone,
    required this.distance,
    required this.attributes,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["id"],
        alias: json["alias"],
        name: json["name"],
        imageUrl: json["image_url"],
        isClosed: json["is_closed"],
        url: json["url"],
        reviewCount: json["review_count"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        rating: json["rating"]?.toDouble(),
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
        location: Location.fromJson(json["location"]),
        phone: json["phone"],
        displayPhone: json["display_phone"],
        distance: json["distance"]?.toDouble(),
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "name": name,
        "image_url": imageUrl,
        "is_closed": isClosed,
        "url": url,
        "review_count": reviewCount,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "rating": rating,
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
        "location": location.toJson(),
        "phone": phone,
        "display_phone": displayPhone,
        "distance": distance,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  final dynamic businessTempClosed;
  final String? menuUrl;
  final dynamic open24Hours;
  final dynamic waitlistReservation;

  Attributes({
    required this.businessTempClosed,
    required this.menuUrl,
    required this.open24Hours,
    required this.waitlistReservation,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        businessTempClosed: json["business_temp_closed"],
        menuUrl: json["menu_url"],
        open24Hours: json["open24_hours"],
        waitlistReservation: json["waitlist_reservation"],
      );

  Map<String, dynamic> toJson() => {
        "business_temp_closed": businessTempClosed,
        "menu_url": menuUrl,
        "open24_hours": open24Hours,
        "waitlist_reservation": waitlistReservation,
      };
}

class Category {
  final String alias;
  final String title;
  final bool isSelected;
  final int count;

  Category({
    required this.alias,
    required this.title,
    this.isSelected = false,
    this.count = 0,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      alias: json["alias"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alias": alias,
      "title": title,
    };
  }

  Category copyWith({bool? isSelected}) {
    return Category(
      alias: alias,
      title: title,
      count: count,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class Location {
  final String address1;
  final String? address2;
  final String? address3;
  final String zipCode;
  final List<String> displayAddress;

  Location({
    required this.address1,
    required this.address2,
    required this.address3,
    required this.zipCode,
    required this.displayAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address1: json["address1"],
        address2: json["address2"],
        address3: json["address3"],
        zipCode: json["zip_code"],
        displayAddress:
            List<String>.from(json["display_address"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "zip_code": zipCode,
        "display_address": List<dynamic>.from(displayAddress.map((x) => x)),
      };
}
