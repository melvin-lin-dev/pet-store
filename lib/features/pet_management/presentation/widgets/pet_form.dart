import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/domain/entities/pet.dart';

class PetForm extends StatelessWidget {
  final void Function(dynamic) onSubmit;
  final dynamic pet;

  const PetForm({required this.onSubmit, this.pet});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: '');
    final categoryController = TextEditingController(text: '');
    final tagsController = TextEditingController(text: '');
    final statusController = TextEditingController(text: '');

    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextField(
          controller: categoryController,
          decoration: InputDecoration(labelText: 'Category'),
        ),
        TextField(
          controller: tagsController,
          decoration: InputDecoration(labelText: 'Tags'),
        ),
        TextField(
          controller: statusController,
          decoration: InputDecoration(labelText: 'Status'),
        ),
        ElevatedButton(
          onPressed: () {
            final payload = Pet(
              id: 9999,
              name: nameController.text,
              category: categoryController.text,
              tags: tagsController.text.split(','),
              status: statusController.text
            );

            onSubmit(payload);
          },
          child: Text(pet == null ? 'Create' : 'Update'),
        ),
      ],
    );
  }
}
