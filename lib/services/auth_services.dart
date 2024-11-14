import 'package:booksgr/models/user.dart';
import 'package:booksgr/services/client.dart';

class AuthServices {
  Future<String> signup({required User user}) async {
    late String token;
    try {
      Response response = await Client.dio.post("/signup", data: user.toJson());
      token = response.data["token"];
    } catch (error) {
      print("error");
    }
    return token;
  }

  Future<String> signin({required User user}) async {
    late String token;
    try {
      Response response = await Client.dio.post("/signin", data: user.toJson());
      token = response.data["token"];
    } catch (error) {
      print("error");
    }
    return token;
  }
}
