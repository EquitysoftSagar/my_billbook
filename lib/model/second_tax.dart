class SecondTax {
  double tax;
  double taxPercentage;
  String taxLabel;
  bool deductible;
  bool including;

  SecondTax(
      {this.tax,
        this.taxPercentage,
      this.taxLabel,
      this.deductible,
      this.including});

  SecondTax.fromJson(Map<String, dynamic> json) {
    tax = json['tax'];
    taxPercentage = json['tax_percentage'];
    deductible = json['deductible'];
    including = json['including'];
    taxLabel = json['tax_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax'] = this.tax;
    data['tax_percentage'] = this.taxPercentage;
    data['deductible'] = this.deductible;
    data['including'] = this.including;
    data['tax_label'] = this.taxLabel;
    return data;
  }
}
