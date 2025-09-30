import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/data/repositories/pet_repository.dart';
import 'package:pet_store/features/pet_management/domain/entities/pet.dart';
import 'package:pet_store/features/pet_management/presentation/widgets/pet_form.dart';

class PetEditPage extends StatelessWidget {
  final PetRepository repository;
  final String id;

  const PetEditPage({Key? key, required this.repository, required this.id})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pet - Update')),
      body: FutureBuilder<Pet>(
        future: repository.fetchPet(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('This pet is not available'));
          }

          final pet = snapshot.data!;

          return PetForm(
            onSubmit: (payload) async {
              try {
                await repository.updatePet(payload, id);

                context.go('/');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update pet: $e')),
                );
              }
            },
            pet: pet,
          );
        },
      ),
    );
  }
}
