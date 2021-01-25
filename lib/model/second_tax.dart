class SecondTax {
  int tax;
  String taxLabel;
  bool deductible;
  bool including;

  SecondTax(
      {this.tax,
      this.taxLabel,
      this.deductible,
      this.including});

  SecondTax.fromJson(Map<String, dynamic> json) {
    tax = json['tax'];
    deductible = json['deductible'];
    including = json['including'];
    taxLabel = json['tax_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax'] = this.tax;
    data['deductible'] = this.deductible;
    data['including'] = this.including;
    data['tax_label'] = this.taxLabel;
    return data;
  }
}
