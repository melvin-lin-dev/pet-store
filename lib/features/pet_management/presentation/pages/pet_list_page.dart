import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_store/features/pet_management/data/repositories/pet_repository.dart';
import 'package:pet_store/features/pet_management/domain/entities/pet.dart';
import 'package:pet_store/features/pet_management/presentation/widgets/pet_data_source.dart';

class PetListPage extends StatefulWidget {
  final PetRepository repository;

  const PetListPage({super.key, required this.repository});

  @override
  State<PetListPage> createState() => _PetListPageState();
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
    setState(() => isLoading = true);

    try {
      final data = await widget.repository.fetchPets();

      if (!mounted) return;

      setState(() {
        pets = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);

      if (!mounted) return;

      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to fetch pets: $e')));
    }
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
            : !kIsWeb
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: PaginatedDataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Tags')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Action')),
                  ],
                  source: PetDataSource(
                    pets: pets,
                    context: context,
                    deletePet: deletePet,
                  ),
                  rowsPerPage: 10,
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  final pet = pets[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.go('/purchase/${pet.id}');
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.pets, size: 48, color: Colors.teal),
                          const SizedBox(height: 12),
                          Text(
                            "Pet: ${pet.name}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
