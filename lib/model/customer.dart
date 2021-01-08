import 'package:cloud_firestore/cloud_firestore.dart';

import 'address.dart';

class Customer {
  String name;
  String email;
  int phoneNumber;
  int businessNumber;
  String additionalInformation;
  Address address;
  Address shippingAddress;
  String userId;
  Timestamp updatedAt;
  Timestamp createdAt;
  bool isTrash;

  Customer(
      {this.name,
        this.email,
        this.phoneNumber,
        this.businessNumber,
        this.additionalInformation,
        this.address,
        this.shippingAddress,
      this.userId,
      this.createdAt,
      this.updatedAt,
        this.isTrash
      });

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userId = json['user_id'];
    phoneNumber = json['phone_number'];
    businessNumber = json['business_number'];
    additionalInformation = json['additional_information'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    shippingAddress = json['shipping_address'] != null
        ? new Address.fromJson(json['shipping_address'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isTrash = json['is_trash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['phone_number'] = this.phoneNumber;
    data['business_number'] = this.businessNumber;
    data['additional_information'] = this.additionalInformation;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_trash'] = this.isTrash;
    return data;
  }
}