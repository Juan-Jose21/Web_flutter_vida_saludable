import 'dart:convert';

import 'package:get/get.dart';

import '../environment/environment.dart';
import '../models/response_api.dart';
import '../models/user_models.dart';

class UsersProviders extends GetConnect {

  String url = Environment.API_URL + 'api/users';

  // Future<ResponseApi> login(String email, String password) async {
  //   Response response = await post(
  //       '$url/login',
  //       {
  //         'email': email,
  //         'password': password
  //       },
  //       headers: {
  //         'Content-Type': 'application/json'
  //       }
  //   );
  //
  //   if (response.body == null) {
  //     Get.snackbar('Error', 'No se pudo ejecutar la ejecution');
  //     return ResponseApi();
  //   }
  //   ResponseApi responseApi = ResponseApi.fromJson(response.body);
  //   return responseApi;
  // }

  Future<ResponseApi> create(User exercise) async {

    final Map<String, dynamic> userJson = {
      'name': exercise.name,
      'last_name': exercise.last_name,
      'email': exercise.email,
      'phone': exercise.phone,
      'password': exercise.password,
      'proyecto_id': exercise.proyecto_id,
      'role_id': exercise.role_id,
    };

    Response response = await post(
      '$url/create',
      jsonEncode(userJson),
      headers: {'Content-Type': 'application/json'},
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
