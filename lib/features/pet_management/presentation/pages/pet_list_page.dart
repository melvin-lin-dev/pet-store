import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/data/repositories/pet_repository.dart';
import 'package:pet_store/features/pet_management/domain/entities/pet.dart';

class PetListPage extends StatelessWidget {
  final PetRepository repository;

  const PetListPage({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pet List'),
            IconButton(
              onPressed: () {
                context.go('/create');
              },
              icon: Icon(Icons.add, color: Colors.blue),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Pet>>(
        future: repository.fetchPets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No pets available'));
          }

          final pets = snapshot.data!;

          return DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Tags')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Action')),
            ],
            rows: pets
                .map(
                  (pet) => DataRow(
                    cells: [
                      DataCell(Text(pet.name)),
                      DataCell(Text(pet.category)),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: pet.tags.map((tag) => Text(tag)).toList(),
                        ),
                      ),
                      DataCell(Text(pet.status)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context.go('/edit/${pet.id}');
                              },
                              icon: Icon(Icons.edit, color: Colors.yellow),
                              tooltip: 'Edit',
                            ),
                            IconButton(
                              onPressed: () {
                                print("delete");
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                              tooltip: 'Delete',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
