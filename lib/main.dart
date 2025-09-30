import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/presentation/pages/pet_create_page.dart';
import 'package:pet_store/features/pet_management/presentation/pages/pet_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => PetListPage()),
      GoRoute(path: '/create', builder: (context, state) => PetCreatePage()),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: 'Pet Store', routerConfig: _router);
  }
}
