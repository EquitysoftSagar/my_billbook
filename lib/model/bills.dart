import 'document.dart';

class Bills {
  String name;
  String userId;
  String settingPrefix;
  String settingDefaultNote;
  String settingDefaultTermsAndCondition;
  String settingDefaultEmailMessage;
  int settingNext;
  String id;

  Bills(
      {this.name,
      this.userId,
      this.settingNext = 1,
      this.settingPrefix = '',
      this.settingDefaultNote = '',
      this.settingDefaultEmailMessage = '',
      this.settingDefaultTermsAndCondition = '',
      this.id = ''});

  Bills.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
    settingPrefix = json['setting_prefix'];
    settingNext = json['setting_next'];
    settingDefaultNote = json['setting_default_note'];
    settingDefaultTermsAndCondition =
        json['setting_default_terms_and_condition'];
    settingDefaultEmailMessage = json['setting_default_email_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['setting_prefix'] = this.settingPrefix;
    data['setting_next'] = this.settingNext;
    data['setting_default_note'] = this.settingDefaultNote;
    data['setting_default_terms_and_condition'] =
        this.settingDefaultTermsAndCondition;
    data['setting_default_email_message'] = this.settingDefaultEmailMessage;
    return data;
  }
}
