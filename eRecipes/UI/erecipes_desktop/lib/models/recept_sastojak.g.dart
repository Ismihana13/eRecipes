// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recept_sastojak.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceptSastojak _$ReceptSastojakFromJson(Map<String, dynamic> json) =>
    ReceptSastojak()
      ..receptSastojakId = (json['receptSastojakId'] as num?)?.toInt()
      ..receptId = (json['receptId'] as num?)?.toInt()
      ..sastojakId = (json['sastojakId'] as num?)?.toInt()
      ..kolicina = (json['kolicina'] as num?)?.toDouble()
      ..mjernaJedinica = json['mjernaJedinica'] as String?
      ..recept = json['recept'] == null
          ? null
          : Recept.FromJson(json['recept'] as Map<String, dynamic>)
      ..sastojak = json['sastojak'] == null
          ? null
          : Sastojak.FromJson(json['sastojak'] as Map<String, dynamic>);

Map<String, dynamic> _$ReceptSastojakToJson(ReceptSastojak instance) =>
    <String, dynamic>{
      'receptSastojakId': instance.receptSastojakId,
      'receptId': instance.receptId,
      'sastojakId': instance.sastojakId,
      'kolicina': instance.kolicina,
      'mjernaJedinica': instance.mjernaJedinica,
      'recept': instance.recept,
      'sastojak': instance.sastojak,
    };
