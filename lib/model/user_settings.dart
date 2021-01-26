class UserSettings {
  String dueInDays;
  bool sendMeCopy;
  String dateFormat;
  String language;

  UserSettings({
    this.dueInDays = '7',
    this.sendMeCopy = false,
    this.dateFormat = '05 Apr 2014',
    this.language = 'English',
  });

  UserSettings.fromJson(Map<String, dynamic> json) {
    dueInDays = json['due_in_days'];
    sendMeCopy = json['send_me_copy'];
    dateFormat = json['date_format'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['due_in_days'] = this.dueInDays;
    data['send_me_copy'] = this.sendMeCopy;
    data['date_format'] = this.dateFormat;
    data['language'] = this.language;
    return data;
  }
}
