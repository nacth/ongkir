import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://reqres.in/api/users");
  final response = await http.post(
    url,
    body: {"name": "morpheus", "job": "leader"},
  );

  print(response.body);
}
