// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sastojak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sastojak _$SastojakFromJson(Map<String, dynamic> json) => Sastojak()
  ..sastojakId = (json['sastojakId'] as num?)?.toInt()
  ..naziv = json['naziv'] as String?;

Map<String, dynamic> _$SastojakToJson(Sastojak instance) => <String, dynamic>{
      'sastojakId': instance.sastojakId,
      'naziv': instance.naziv,
    };
