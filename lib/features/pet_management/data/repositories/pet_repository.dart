import 'package:pet_store/features/pet_management/data/api/pet_api.dart';
import 'package:pet_store/features/pet_management/domain/entities/pet.dart';

class PetRepository {
  final PetApi api;

  PetRepository({required this.api});

  Future<List<Pet>> fetchPets() async {
    final models = await api.getPets();
    final entities = models
        .map(
          (m) => Pet(
            id: m.id,
            name: m.name,
            tags: m.tags.map((t) => t.name).toList(),
            status: m.status,
            category: m.category?.name ?? '-',
          ),
        )
        .toList();

    return entities;
  }

  Future<dynamic> createPet(Pet payload) async {
    final formattedPayload = {
      'id': payload.id,
      'name': payload.name,
      'category': {'id': 123, 'name': payload.category},
      'tags': payload.tags
          .asMap()
          .entries
          .map((entry) => {'id': entry.key + 1, 'name': entry.value})
          .toList(),
      'status': payload.status,
    };
    await api.createPet(formattedPayload);
    return {'message': 'Pet Created Successfully'};
  }
}
