import 'package:matamix_task/core/constants/api_constants.dart';
import 'package:matamix_task/core/network/api_client.dart';
import 'package:matamix_task/features/homepage/data/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers();
}

class UserRepositoryImpl implements UserRepository {
  final ApiClient _apiClient;

  UserRepositoryImpl({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _apiClient.get(ApiConstants.usersEndpoint);

    if (response is List) {
      return response
          .map((userJson) => UserModel.fromJson(userJson as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Unexpected data format for users list.');
    }
  }
}
