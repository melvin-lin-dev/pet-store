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

  Future<PetModel> getPet(String id) async {
    final response = await dio.get('/pet/$id');
    return PetModel.fromJson(response.data);
  }

  Future<Response> createPet(payload) async {
    final response = await dio.post('/pet', data: payload);
    return response;
  }

  Future<Response> updatePet(payload, String id) async {
    final response = await dio.post('/pet', data: payload);
    return response;
  }

  Future<Response> deletePet(String id) async {
    final response = await dio.delete(
      '/pet/$id',
      options: Options(
        responseType: ResponseType.plain, // treat response as plain text
      ),
    );
    return response;
  }
}
