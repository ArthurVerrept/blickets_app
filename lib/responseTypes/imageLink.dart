import 'dart:convert';

class ImageLink {
  final String image;

  const ImageLink({
    required this.image,
  });

  factory ImageLink.parseBody(String jsonString) {
    var json = jsonDecode(jsonString);
    return ImageLink(
      image: json['image'],
    );
  }
}
