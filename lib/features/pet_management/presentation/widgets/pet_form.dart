import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            onSubmit(null);

            context.go('/');
          },
          child: Text(pet == null ? 'Create' : 'Update'),
        ),
      ],
    );
  }
}
