import 'document.dart';

class Bills {
  String name;
  String userId;

  Bills({this.name, this.userId,});

  Bills.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_id'] = this.userId;
    return data;
  }
}
