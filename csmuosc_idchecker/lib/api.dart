import 'package:http/http.dart';
import "dart:convert";
import 'dart:async';

class Member {
  final int id;
  final String stuId;
  final String name;
  final String sex;
  final String department;
  final String type;

  Member(
      {this.id, this.stuId, this.name, this.sex, this.department, this.type});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
        id: json['id'],
        stuId: json['stuId'],
        name: json["name"],
        sex: json["sex"],
        department: json["department"],
        type: json["type"]);
  }
}

class HttpService {
  final String postsURL =
      "http://web.oxygentw.net:3000/y=109&stuId=0770012&k=123456";

  Future<List<Member>> getAPIdata() async {
    Response res = await get(postsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Member> _data = body
          .map(
            (dynamic item) => Member.fromJson(item),
          )
          .toList();

      return _data;
    } else {
      throw "Can't get API.";
    }
  }
}
