// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sastojak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sastojak _$SastojakFromJson(Map<String, dynamic> json) => Sastojak(
      naziv: json['naziv'] as String?,
      sastojakId: (json['sastojakId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SastojakToJson(Sastojak instance) => <String, dynamic>{
      'sastojakId': instance.sastojakId,
      'naziv': instance.naziv,
    };
