class SecondTax {
  String tax;
  String taxType;
  String taxLabel;

  SecondTax({this.tax, this.taxType, this.taxLabel});

  SecondTax.fromJson(Map<String, dynamic> json) {
    tax = json['tax'];
    taxType = json['tax_type'];
    taxLabel = json['tax_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['tax_label'] = this.taxLabel;
    return data;
  }
}