import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String name;
  int price;
  String description;
  String userId;
  Timestamp updatedAt;
  Timestamp createdAt;
  int status;

  Item(
      {this.name,
        this.price,
        this.description,
        this.userId,
      this.updatedAt,
      this.createdAt,
        this.status
      });

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}