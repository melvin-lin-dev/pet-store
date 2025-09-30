import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/data/api/pet_api.dart';
import 'package:pet_store/features/pet_management/data/repositories/pet_repository.dart';
import 'package:pet_store/features/pet_management/presentation/pages/pet_create_page.dart';
import 'package:pet_store/features/pet_management/presentation/pages/pet_edit_page.dart';
import 'package:pet_store/features/pet_management/presentation/pages/pet_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final Dio dio;
  late final PetApi petApi;
  late final PetRepository petRepository;

  MyApp({super.key}) {
    dio = Dio(BaseOptions(baseUrl: 'https://petstore3.swagger.io/api/v3'));
    petApi = PetApi(dio: dio);
    petRepository = PetRepository(api: petApi);
  }

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => PetListPage(repository: petRepository),
      ),
      GoRoute(path: '/create', builder: (context, state) => PetCreatePage()),
      GoRoute(
        path: '/edit/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] as String;
          return PetEditPage(id: int.parse(id));
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: 'Pet Store', routerConfig: _router);
  }
}
