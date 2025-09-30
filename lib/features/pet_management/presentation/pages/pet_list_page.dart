import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/data/repositories/pet_repository.dart';
import 'package:pet_store/features/pet_management/domain/entities/pet.dart';

class PetListPage extends StatefulWidget {
  final PetRepository repository;

  const PetListPage({Key? key, required this.repository}) : super(key: key);

  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  List<Pet> pets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPets();
  }

  void deletePet(Pet pet) async {
    try {
      await widget.repository.deletePet(pet.id.toString());

      setState(() {
        pets.remove(pet);
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to create pet: $e')));
    }
  }

  void fetchPets() async {
    final data = await widget.repository.fetchPets();
    setState(() {
      pets = data;
      isLoading = false;
    });
  }

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
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : pets.isEmpty
            ? Text('No pets available')
            : DataTable(
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
                              children: pet.tags
                                  .map((tag) => Text(tag))
                                  .toList(),
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
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
