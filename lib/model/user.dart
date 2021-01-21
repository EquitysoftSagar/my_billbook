import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_billbook/model/company_information.dart';
import 'package:my_billbook/model/user_settings.dart';

class UserModel{
  String id;
  String firstName;
  String lastName;
  String password;
  String email;
  Timestamp createdAt;
  Timestamp updatedAt;
  int status;
  UserSettings userSettings;
  CompanyInformation companyInformation;

  UserModel(
      {
        this.firstName = '',
        this.lastName = '',
        this.password = '',
        this.email = '',
        this.createdAt,
        this.updatedAt,
        this.userSettings,
        this.companyInformation,
        this.status = 1});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    password = json['password'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    userSettings = json['settings'] != null
        ? new UserSettings.fromJson(json['settings'])
        : null;
    companyInformation = json['company_information'] != null
        ? new CompanyInformation.fromJson(json['company_information'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.userSettings != null) {
      data['settings'] = this.userSettings.toJson();
    }
    if (this.companyInformation != null) {
      data['company_information'] = this.companyInformation.toJson();
    }
    return data;
  }
}