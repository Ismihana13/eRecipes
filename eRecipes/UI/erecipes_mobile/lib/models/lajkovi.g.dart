// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lajkovi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lajkovi _$LajkoviFromJson(Map<String, dynamic> json) => Lajkovi(
      lajkoviId: (json['lajkoviId'] as num?)?.toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      receptId: (json['receptId'] as num?)?.toInt(),
      datumLajkanja: json['datumLajkanja'] == null
          ? null
          : DateTime.parse(json['datumLajkanja'] as String),
      korisnik: json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>),
      recept: json['recept'] == null
          ? null
          : Recept.FromJson(json['recept'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LajkoviToJson(Lajkovi instance) => <String, dynamic>{
      'lajkoviId': instance.lajkoviId,
      'korisnikId': instance.korisnikId,
      'receptId': instance.receptId,
      'datumLajkanja': instance.datumLajkanja?.toIso8601String(),
      'korisnik': instance.korisnik,
      'recept': instance.recept,
    };
