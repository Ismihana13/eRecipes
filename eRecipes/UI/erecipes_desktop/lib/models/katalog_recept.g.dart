// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'katalog_recept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KatalogRecept _$KatalogReceptFromJson(Map<String, dynamic> json) =>
    KatalogRecept()
      ..katalogReceptId = (json['katalogReceptId'] as num?)?.toInt()
      ..receptId = (json['receptId'] as num?)?.toInt()
      ..katalogId = (json['katalogId'] as num?)?.toInt()
      ..recept = json['recept'] == null
          ? null
          : Recept.FromJson(json['recept'] as Map<String, dynamic>)
      ..katalog = json['katalog'] == null
          ? null
          : Katalog.FromJson(json['katalog'] as Map<String, dynamic>);

Map<String, dynamic> _$KatalogReceptToJson(KatalogRecept instance) =>
    <String, dynamic>{
      'katalogReceptId': instance.katalogReceptId,
      'receptId': instance.receptId,
      'katalogId': instance.katalogId,
      'recept': instance.recept,
      'katalog': instance.katalog,
    };
