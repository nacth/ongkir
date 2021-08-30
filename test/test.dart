import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  final response =
      await http.get(url, headers: {"key": "1b34ed35dc3f4a13eacb28fced5c8ef5"});

  print(response.body);
}
