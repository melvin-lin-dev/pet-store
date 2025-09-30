import 'package:flutter/material.dart';

class PetCreatePage extends StatelessWidget {
  const PetCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: '');
    final categoryController = TextEditingController(text: '');
    final tagsController = TextEditingController(text: '');
    final statusController = TextEditingController(text: '');

    return Scaffold(
      appBar: AppBar(title: Text('Pet - Create')),
      body: Column(
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
              print('submit');
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
}
