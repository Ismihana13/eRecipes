// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recept _$ReceptFromJson(Map<String, dynamic> json) => Recept()
  ..receptId = (json['receptId'] as num?)?.toInt()
  ..naziv = json['naziv'] as String?
  ..slika = json['slika'] as String?
  ..vrstaJelaId = (json['vrstaJelaId'] as num?)?.toInt()
  ..kategorijaId = (json['kategorijaId'] as num?)?.toInt()
  ..vrijemePripreme = (json['vrijemePripreme'] as num?)?.toInt()
  ..korisnikId = (json['korisnikId'] as num?)?.toInt()
  ..premium = json['premium'] as bool?
  ..stateMachine = json['stateMachine'] as String?
  ..opisRecepta = json['opisRecepta'] as String?
  ..datumObjave = json['datumObjave'] == null
      ? null
      : DateTime.parse(json['datumObjave'] as String)
  ..opisPripreme = json['opisPripreme'] as String?
  ..sastojci = (json['sastojci'] as List<dynamic>?)
      ?.map((e) => ReceptSastojak.FromJson(e as Map<String, dynamic>))
      .toList()
  ..korisnik = json['korisnik'] == null
      ? null
      : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>);

Map<String, dynamic> _$ReceptToJson(Recept instance) => <String, dynamic>{
      'receptId': instance.receptId,
      'naziv': instance.naziv,
      'slika': instance.slika,
      'vrstaJelaId': instance.vrstaJelaId,
      'kategorijaId': instance.kategorijaId,
      'vrijemePripreme': instance.vrijemePripreme,
      'korisnikId': instance.korisnikId,
      'premium': instance.premium,
      'stateMachine': instance.stateMachine,
      'opisRecepta': instance.opisRecepta,
      'datumObjave': instance.datumObjave?.toIso8601String(),
      'opisPripreme': instance.opisPripreme,
      'sastojci': instance.sastojci,
      'korisnik': instance.korisnik,
    };
