import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/data/repositories/pet_repository.dart';
import 'package:pet_store/features/pet_management/domain/entities/pet.dart';

class PetPurchaseList extends StatelessWidget {
  final PetRepository repository;
  final String id;

  const PetPurchaseList({
    super.key,
    required this.repository,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pet - Purchase')),
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

          return Center(
            child: Column(
              children: [
                Text('Thank you for your purchase'),
                Text('Item'),
                Text(pet.name),
                ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: Text('BACK TO HOMEPAGE'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
