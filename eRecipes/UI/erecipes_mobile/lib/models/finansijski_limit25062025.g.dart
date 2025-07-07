// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finansijski_limit25062025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinansijskiLimit25062025 _$FinansijskiLimit25062025FromJson(
        Map<String, dynamic> json) =>
    FinansijskiLimit25062025()
      ..finansijskiLimit25062025Id =
          (json['finansijskiLimit25062025Id'] as num?)?.toInt()
      ..limit = (json['limit'] as num?)?.toDouble()
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>)
      ..kategorijaTransakcije25062025 =
          json['kategorijaTransakcije25062025'] == null
              ? null
              : KategorijaTransakcije25062025.FromJson(
                  json['kategorijaTransakcije25062025'] as Map<String, dynamic>)
      ..kategorijaTransakcije25062025Id =
          (json['kategorijaTransakcije25062025Id'] as num?)?.toInt();

Map<String, dynamic> _$FinansijskiLimit25062025ToJson(
        FinansijskiLimit25062025 instance) =>
    <String, dynamic>{
      'finansijskiLimit25062025Id': instance.finansijskiLimit25062025Id,
      'limit': instance.limit,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'kategorijaTransakcije25062025': instance.kategorijaTransakcije25062025,
      'kategorijaTransakcije25062025Id':
          instance.kategorijaTransakcije25062025Id,
    };
