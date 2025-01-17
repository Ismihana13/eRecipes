// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omiljeni_recept.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmiljeniRecept _$OmiljeniReceptFromJson(Map<String, dynamic> json) =>
    OmiljeniRecept()
      ..omiljeReceptId = (json['omiljeReceptId'] as num?)?.toInt()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..receptId = (json['receptId'] as num?)?.toInt()
      ..datumDodavanja = json['datumDodavanja'] == null
          ? null
          : DateTime.parse(json['datumDodavanja'] as String)
      ..recept = json['recept'] == null
          ? null
          : Recept.FromJson(json['recept'] as Map<String, dynamic>);

Map<String, dynamic> _$OmiljeniReceptToJson(OmiljeniRecept instance) =>
    <String, dynamic>{
      'omiljeReceptId': instance.omiljeReceptId,
      'korisnikId': instance.korisnikId,
      'receptId': instance.receptId,
      'datumDodavanja': instance.datumDodavanja?.toIso8601String(),
      'recept': instance.recept,
    };
