import 'dart:convert';
class cat {
  final String id;
  final String url;
  final int width;
  final int height;

  cat({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory cat.fromJson(Map<String, dynamic> json) => cat(
    id: json["id"],
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "width": width,
    "height": height,
  };
}

List<cat> catFromJson(String str) => List<cat>.from(json.decode(str).map((x) => cat.fromJson(x)));

String catToJson(List<cat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
