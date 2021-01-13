// To parse this JSON data, do
//
//     final petanimals = petanimalsFromJson(jsonString);

import 'dart:convert';

Petanimals petanimalsFromJson(String str) => Petanimals.fromJson(json.decode(str));

String petanimalsToJson(Petanimals data) => json.encode(data.toJson());

class Petanimals {
  Petanimals({
    this.status,
    this.data,
  });

  bool status;
  List<Datum> data;

  factory Petanimals.fromJson(Map<String, dynamic> json) => Petanimals(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.title,
    this.items,
  });

  String title;
  List<Item> items;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.image,
    this.title,
    this.subTitle,
    this.months,
    this.length,
    this.gender,
    this.distance,
  });

  String image;
  String title;
  String subTitle;
  int months;
  int length;
  Gender gender;
  int distance;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    image: json["image"],
    title: json["title"],
    subTitle: json["sub_title"],
    months: json["months"],
    length: json["length"],
    gender: genderValues.map[json["gender"]],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "title": title,
    "sub_title": subTitle,
    "months": months,
    "length": length,
    "gender": genderValues.reverse[gender],
    "distance": distance,
  };
}

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({
  "female": Gender.FEMALE,
  "male": Gender.MALE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
