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
      ..vrstaJelaId = (json['vrstaJelaId'] as num?)?.toInt()
      ..kategorijaId = (json['kategorijaId'] as num?)?.toInt()
      ..vrijemePripreme = (json['vrijemePripreme'] as num?)?.toInt()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..opisRecepta = json['opisRecepta'] as String?
      ..datumObjave = json['datumObjave'] == null
          ? null
          : DateTime.parse(json['datumObjave'] as String);

Map<String, dynamic> _$ReceptToJson(Recept instance) => <String, dynamic>{
      'receptId': instance.receptId,
      'naziv': instance.naziv,
      'slika': instance.slika,
      'vrstaJelaId': instance.vrstaJelaId,
      'kategorijaId': instance.kategorijaId,
      'vrijemePripreme': instance.vrijemePripreme,
      'korisnikId': instance.korisnikId,
      'opisRecepta': instance.opisRecepta,
      'datumObjave': instance.datumObjave?.toIso8601String(),
    };
