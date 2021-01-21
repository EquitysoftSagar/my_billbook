class AddressModel {
  String address1;
  String address2;
  String city;
  String state;
  String zip;
  String country;

  AddressModel(
      {this.address1 = '',
        this.address2 = '',
        this.city = '',
        this.state = '',
        this.zip = '',
        this.country = ''});

  AddressModel.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    return data;
  }
}