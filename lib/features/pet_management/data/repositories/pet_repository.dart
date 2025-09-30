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
}
