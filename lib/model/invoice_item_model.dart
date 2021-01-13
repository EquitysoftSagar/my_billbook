import 'package:cloud_firestore/cloud_firestore.dart';

class InvoiceItemModel {
  String name;
  String price;
  String description;
  String userId;
  String quantity;
  String discount;
  String amount;
  Timestamp updatedAt;
  Timestamp createdAt;
  int status;

  InvoiceItemModel(
      {this.name,
        this.price,
        this.description,
        this.userId,
        this.quantity,
        this.discount,
        this.updatedAt,
        this.createdAt,
        this.status,
        this.amount
      });

  InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    status = json['status'];
    quantity = json['quantity'];
    discount = json['discount'];
    amount = json['amount'];
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
    data['amount'] = this.amount;
    return data;
  }
}