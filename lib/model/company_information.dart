import 'package:my_billbook/model/address.dart';

class CompanyInformation {
  String companyName;
  String emailOnInvoice;
  String phoneNumber;
  String additionalInformation;
  String businessNumber;
  String abbreviation;
  AddressModel address;

  CompanyInformation(
      {this.companyName = '',
        this.emailOnInvoice = '',
        this.phoneNumber = '',
        this.additionalInformation = '',
        this.businessNumber = '',
        this.abbreviation = '',
        this.address});

  CompanyInformation.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    emailOnInvoice = json['email_on_invoice'];
    phoneNumber = json['phone_number'];
    additionalInformation = json['additional_information'];
    businessNumber = json['business_number'];
    abbreviation = json['abbreviation'];
    address =
    json['address'] != null ? new AddressModel.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['email_on_invoice'] = this.emailOnInvoice;
    data['phone_number'] = this.phoneNumber;
    data['additional_information'] = this.additionalInformation;
    data['business_number'] = this.businessNumber;
    data['abbreviation'] = this.abbreviation;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}