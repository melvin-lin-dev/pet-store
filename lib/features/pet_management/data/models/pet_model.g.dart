// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetModel _$PetModelFromJson(Map<String, dynamic> json) => PetModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  tags: (json['tags'] as List<dynamic>)
      .map((e) => TagModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: json['status'] as String,
  category: json['category'] == null
      ? null
      : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PetModelToJson(PetModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'tags': instance.tags,
  'status': instance.status,
  'category': instance.category,
};
