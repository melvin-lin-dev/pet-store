import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/data/repositories/pet_repository.dart';
import 'package:pet_store/features/pet_management/presentation/widgets/pet_form.dart';

class PetCreatePage extends StatelessWidget {
  final PetRepository repository;

  const PetCreatePage({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pet - Create')),
      body: PetForm(
        onSubmit: (payload) async {
          try {
            await repository.createPet(payload);

            context.go('/');
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Failed to create pet: $e')));
          }
        },
      ),
    );
  }
}
