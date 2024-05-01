import 'dart:convert';

class UserInfoModel {
  String? id;
  String? name;
  String? username;
  bool? isAdmin;

  UserInfoModel({this.id, this.name, this.username, this.isAdmin});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['is_admin'] = isAdmin;
    return data;
  }

  String toJsonString() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['is_admin'] = isAdmin;
    return json.encode(data);
  }
}