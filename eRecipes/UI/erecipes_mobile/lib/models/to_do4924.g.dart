// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do4924.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDo4924 _$ToDo4924FromJson(Map<String, dynamic> json) => ToDo4924(
      (json['korisnikId'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['opis'] as String?,
      json['datumIzvrsenja'] == null
          ? null
          : DateTime.parse(json['datumIzvrsenja'] as String),
      json['status'] as String?,
    )
      ..ToDo4924Id = (json['ToDo4924Id'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>);

Map<String, dynamic> _$ToDo4924ToJson(ToDo4924 instance) => <String, dynamic>{
      'ToDo4924Id': instance.ToDo4924Id,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'datumIzvrsenja': instance.datumIzvrsenja?.toIso8601String(),
      'status': instance.status,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
    };
