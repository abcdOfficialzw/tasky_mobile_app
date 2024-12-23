class UserProfileResponseModel {
  int? id;
  String? fullName;
  String? username;
  String? password;
  Audit? audit;
  bool? enabled;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? credentialsNonExpired;
  List<Authorities>? authorities;

  UserProfileResponseModel(
      {this.id,
      this.fullName,
      this.username,
      this.password,
      this.audit,
      this.enabled,
      this.accountNonExpired,
      this.accountNonLocked,
      this.credentialsNonExpired,
      this.authorities});

  UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    password = json['password'];
    audit = json['audit'] != null ? new Audit.fromJson(json['audit']) : null;
    enabled = json['enabled'];
    accountNonExpired = json['accountNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    credentialsNonExpired = json['credentialsNonExpired'];
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(new Authorities.fromJson(v));
      });
    }
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
    if (this.authorities != null) {
      data['authorities'] = this.authorities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Audit {
  String? createdDate;
  String? modifiedDate;
  String? createdBy;
  String? modifiedBy;

  Audit({this.createdDate, this.modifiedDate, this.createdBy, this.modifiedBy});

  Audit.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    return data;
  }
}

class Authorities {
  String? authority;

  Authorities({this.authority});

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}
