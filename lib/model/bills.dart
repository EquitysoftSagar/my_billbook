import 'document.dart';

class Bills {
  String name;
  String userId;
  String settingPrefix;
  String settingNext;

  Bills({this.name, this.userId,this.settingNext = '',this.settingPrefix = ''});

  Bills.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
    settingPrefix = json['setting_prefix'];
    settingNext = json['setting_next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['setting_prefix'] = this.settingPrefix;
    data['setting_next'] = this.settingNext;
    return data;
  }
}
