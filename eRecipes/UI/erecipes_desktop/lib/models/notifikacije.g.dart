// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifikacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notifikacije _$NotifikacijeFromJson(Map<String, dynamic> json) => Notifikacije(
      notifikacijeId: (json['notifikacijeId'] as num?)?.toInt(),
      naslov: json['naslov'] as String?,
      sadrzaj: json['sadrzaj'] as String?,
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>),
      datumSlanja: json['datumSlanja'] == null
          ? null
          : DateTime.parse(json['datumSlanja'] as String),
      procitano: json['procitano'] as bool?,
    );

Map<String, dynamic> _$NotifikacijeToJson(Notifikacije instance) =>
    <String, dynamic>{
      'notifikacijeId': instance.notifikacijeId,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'datumSlanja': instance.datumSlanja?.toIso8601String(),
      'procitano': instance.procitano,
    };
