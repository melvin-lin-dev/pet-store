import 'package:flutter/material.dart';
import 'package:pet_store/features/pet_management/presentation/widgets/pet_form.dart';

class PetEditPage extends StatelessWidget {
  final int id;

  const PetEditPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pet - Update')),
      body: PetForm(
        onSubmit: (pet) {
          print('Update');
        },
        pet: id
      ),
    );
  }
}
