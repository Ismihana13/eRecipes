// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_prostora_statistika.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaProstoraStatistika _$RezervacijaProstoraStatistikaFromJson(
        Map<String, dynamic> json) =>
    RezervacijaProstoraStatistika(
      json['statusRezervacije'] as String?,
      (json['brojPojavljivanja'] as num).toInt(),
    );

Map<String, dynamic> _$RezervacijaProstoraStatistikaToJson(
        RezervacijaProstoraStatistika instance) =>
    <String, dynamic>{
      'statusRezervacije': instance.statusRezervacije,
      'brojPojavljivanja': instance.brojPojavljivanja,
    };
