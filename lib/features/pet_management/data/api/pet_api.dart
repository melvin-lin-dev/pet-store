import 'package:dio/dio.dart';
import 'package:pet_store/features/pet_management/data/models/pet_model.dart';

class PetApi {
  final Dio dio;

  PetApi({required this.dio});

  Future<List<PetModel>> getPets() async {
    final response = await dio.get(
      '/pet/findByStatus',
      queryParameters: {'status': 'available'},
    );
    final List data = response.data;
    return data.map((json) => PetModel.fromJson(json)).toList();
  }

  Future<dynamic> createPet(payload) async {
    return await dio.post('/pet', data: payload);
  }
}
