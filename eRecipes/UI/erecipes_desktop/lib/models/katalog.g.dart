// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'katalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Katalog _$KatalogFromJson(Map<String, dynamic> json) => Katalog()
  ..katalogId = (json['katalogId'] as num?)?.toInt()
  ..naziv = json['naziv'] as String?
  ..opis = json['opis'] as String?
  ..datumKreiranja = json['datumKreiranja'] == null
      ? null
      : DateTime.parse(json['datumKreiranja'] as String);

Map<String, dynamic> _$KatalogToJson(Katalog instance) => <String, dynamic>{
      'katalogId': instance.katalogId,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'datumKreiranja': instance.datumKreiranja?.toIso8601String(),
    };
