import 'dart:typed_data';

class Photo {
  String imageLink;
  String name;
  String description;
  Uint8List imageByte;

  Photo({this.imageLink, this.name, this.description,this.imageByte});

  Photo.fromJson(Map<String, dynamic> json) {
    imageLink = json['image_link'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_link'] = this.imageLink;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}