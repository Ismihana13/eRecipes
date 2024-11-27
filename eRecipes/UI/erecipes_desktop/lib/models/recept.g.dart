// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recept _$ReceptFromJson(Map<String, dynamic> json) => Recept(
      receptId: (json['receptId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
    )
      ..slika = json['slika'] as String?
      ..vrstaId = (json['vrstaId'] as num?)?.toInt()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt();

Map<String, dynamic> _$ReceptToJson(Recept instance) => <String, dynamic>{
      'receptId': instance.receptId,
      'naziv': instance.naziv,
      'slika': instance.slika,
      'vrstaId': instance.vrstaId,
      'korisnikId': instance.korisnikId,
    };
