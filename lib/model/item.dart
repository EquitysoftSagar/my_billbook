import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String name;
  int price;
  int discount;
  bool gstIncluded;
  String description;
  String userId;
  Timestamp updatedAt;
  Timestamp createdAt;
  bool isTrash;
  int status;

  Item(
      {this.name,
        this.price,
        this.discount,
        this.gstIncluded,
        this.description,
        this.userId,
      this.updatedAt,
      this.createdAt,
        this.status
      });

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    gstIncluded = json['gst_included'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    isTrash = json['is_trash'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['gst_included'] = this.gstIncluded;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_trash'] = this.isTrash;
    data['status'] = this.status;
    return data;
  }
}