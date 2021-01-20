import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_billbook/model/user_settings.dart';

class UserModel{
  String id;
  String companyName;
  String firstName;
  String lastName;
  String password;
  String email;
  String displayEmail;
  Timestamp createdAt;
  Timestamp updatedAt;
  int status;
  UserSettings userSettings;

  UserModel(
      {
        this.companyName = '',
        this.firstName = '',
        this.lastName = '',
        this.password = '',
        this.email = '',
        this.displayEmail = '',
        this.createdAt,
        this.updatedAt,
        this.userSettings,
        this.status = 1});

  UserModel.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    password = json['password'];
    email = json['email'];
    displayEmail = json['display_email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    userSettings = json['settings'] != null
        ? new UserSettings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['display_email'] = this.displayEmail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.userSettings != null) {
      data['settings'] = this.userSettings.toJson();
    }
    return data;
  }
}