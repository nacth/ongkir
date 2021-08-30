import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ongkir/app/data/models/user_model.dart';

void main() async {
  Uri url = Uri.parse("https://reqres.in/api/users/10");
  final response = await http.get(url);
  final user =
      UserModel.fromJson(json.decode(response.body) as Map<String, dynamic>);

  final data = user.data;
  print("${data?.firstName} ${user.data?.lastName}");

  final myJson = userModelToJson(user);
  print(myJson);
}
