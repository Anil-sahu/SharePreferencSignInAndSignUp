class UserData {
  List<Users>? users;

  UserData({this.users});

  UserData.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? name;
  String? id;
  String? atype;

  Users({this.name, this.id, this.atype});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    atype = json['atype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['atype'] = atype;
    return data;
  }
}