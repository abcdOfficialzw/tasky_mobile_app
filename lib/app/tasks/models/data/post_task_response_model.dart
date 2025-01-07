class PostTaskResponseModel {
  String? id;
  String? title;
  bool? isSynced;
  String? description;
  String? deadline;
  String? lastUpdated;
  Audit? audit;
  User? user;

  PostTaskResponseModel(
      {this.id,
      this.title,
      this.isSynced,
      this.description,
      this.deadline,
      this.lastUpdated,
      this.audit,
      this.user});

  PostTaskResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isSynced = json['isSynced'];
    description = json['description'];
    deadline = json['deadline'];
    lastUpdated = json['lastUpdated'];
    audit = json['audit'] != null ? new Audit.fromJson(json['audit']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['isSynced'] = this.isSynced;
    data['description'] = this.description;
    data['deadline'] = this.deadline;
    data['lastUpdated'] = this.lastUpdated;
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Audit {
  String? createdDate;
  String? lastModified;
  String? createdBy;
  String? modifiedBy;

  Audit({this.createdDate, this.lastModified, this.createdBy, this.modifiedBy});

  Audit.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    lastModified = json['lastModified'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['lastModified'] = this.lastModified;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? username;
  String? password;
  Audit? audit;
  bool? enabled;
  List<Null>? authorities;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? credentialsNonExpired;

  User(
      {this.id,
      this.fullName,
      this.username,
      this.password,
      this.audit,
      this.enabled,
      this.authorities,
      this.accountNonExpired,
      this.accountNonLocked,
      this.credentialsNonExpired});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    password = json['password'];
    audit = json['audit'] != null ? new Audit.fromJson(json['audit']) : null;
    enabled = json['enabled'];

    accountNonExpired = json['accountNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    credentialsNonExpired = json['credentialsNonExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['username'] = this.username;
    data['password'] = this.password;
    if (this.audit != null) {
      data['audit'] = this.audit!.toJson();
    }
    data['enabled'] = this.enabled;

    data['accountNonExpired'] = this.accountNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    return data;
  }
}
