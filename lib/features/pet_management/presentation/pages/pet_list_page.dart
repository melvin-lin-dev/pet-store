import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List pets = [
      {
        "name": "Pet 1",
        "category": {"id": 1, "name": "Dogs"},
        "tags": [
          {"id": 0, "name": "string"},
        ],
        "status": "available",
      },
    ];

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
      body: DataTable(
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
                  DataCell(Text(pet['name'])),
                  DataCell(Text(pet['category']['name'])),
                  DataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: (pet['tags'] as List<dynamic>)
                          .map((tag) => Text(tag['name']))
                          .toList(),
                    ),
                  ),
                  DataCell(Text(pet['status'])),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            print('edit');
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
      ),
    );
  }
}
