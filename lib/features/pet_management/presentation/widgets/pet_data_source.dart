import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/domain/entities/pet.dart';

class PetDataSource extends DataTableSource {
  final BuildContext context;
  final List<Pet> pets;
  final Function(Pet) deletePet;

  PetDataSource({
    required this.context,
    required this.pets,
    required this.deletePet,
  });

  @override
  DataRow getRow(int index) {
    if (index >= pets.length) return const DataRow(cells: []);

    final pet = pets[index];

    return DataRow(
      cells: [
        DataCell(Text(pet.name)),
        DataCell(Text(pet.category)),
        DataCell(
          Wrap(
            spacing: 8,
            runSpacing: 4,
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
                onPressed: () => deletePet(pet),
                icon: Icon(Icons.delete, color: Colors.red),
                tooltip: 'Delete',
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => pets.length;

  @override
  int get selectedRowCount => 0;
}
