
class InvoiceItemModel {
  String id;
  String name;
  String price;
  String description;
  String quantity;
  String discount;
  String amount;

  InvoiceItemModel(
      {this.name,
        this.price,
        this.description,
        this.quantity,
        this.discount,
        this.id,
        this.amount
      });

  InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    quantity = json['quantity'];
    discount = json['discount'];
    amount = json['amount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['discount'] = this.discount;
    data['id'] = this.id;
    return data;
  }
}