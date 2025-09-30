import 'package:json_annotation/json_annotation.dart';
import 'package:pet_store/features/pet_management/data/models/category_model.dart';
import 'package:pet_store/features/pet_management/data/models/tag_model.dart';

part 'pet_model.g.dart';

@JsonSerializable()
class PetModel {
  final int id;
  final String name;
  final List<TagModel> tags;
  final String status;
  final CategoryModel? category;

  PetModel({
    required this.id,
    required this.name,
    required this.tags,
    required this.status,
    this.category,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);
  Map<String, dynamic> toJson() => _$PetModelToJson(this);
}
