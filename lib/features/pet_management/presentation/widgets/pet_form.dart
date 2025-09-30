import 'package:flutter/material.dart';
import 'package:pet_store/features/pet_management/domain/entities/pet.dart';

class PetForm extends StatelessWidget {
  final void Function(dynamic) onSubmit;
  final dynamic pet;

  const PetForm({super.key, required this.onSubmit, this.pet});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: pet?.name ?? '');
    final categoryController = TextEditingController(text: pet?.category ?? '');
    final tagsController = TextEditingController(text: pet?.tags.join(',') ?? '');
    final statusController = TextEditingController(text: pet?.status ?? '');

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
              id: pet?.id ?? 9999,
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
