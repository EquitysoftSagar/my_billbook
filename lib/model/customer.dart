import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_billbook/model/address.dart';

class Customer {
  String id;
  String name;
  String email;
  String phoneNumber;
  String businessNumber;
  String additionalInformation;
  AddressModel address;
  AddressModel shippingAddress;
  String userId;
  Timestamp updatedAt;
  Timestamp createdAt;
  int status;

  Customer(
      {this.name,
        this.id,
        this.email,
        this.phoneNumber,
        this.businessNumber,
        this.additionalInformation,
        this.address,
        this.shippingAddress,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.status,
      });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userId = json['user_id'];
    phoneNumber = json['phone_number'];
    businessNumber = json['business_number'];
    additionalInformation = json['additional_information'];
    address =
    json['address'] != null ? new AddressModel.fromJson(json['address']) : null;
    shippingAddress = json['shipping_address'] != null
        ? new AddressModel.fromJson(json['shipping_address'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['status'] = this.status;
    data['customer_id'] = this.status;
    return data;
  }
}