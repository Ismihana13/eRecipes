// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_prostora.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaProstora _$RezervacijaProstoraFromJson(Map<String, dynamic> json) =>
    RezervacijaProstora(
      rezervacijaProstoraId: (json['rezervacijaProstoraId'] as num?)?.toInt(),
      oznaka: json['oznaka'] as String?,
      kapacitet: (json['kapacitet'] as num?)?.toInt(),
      aktivan: json['aktivan'] as bool?,
      datumIVrijemePocetkaRezervacije:
          json['datumIVrijemePocetkaRezervacije'] == null
              ? null
              : DateTime.parse(
                  json['datumIVrijemePocetkaRezervacije'] as String),
      trajanje: (json['trajanje'] as num?)?.toInt(),
      statusRezervacije: json['statusRezervacije'] as String?,
      napomena: json['napomena'] as String?,
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      radniProstorId: (json['radniProstorId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>),
      radniProstor: json['radniProstor'] == null
          ? null
          : RadniProstor.FromJson(json['radniProstor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RezervacijaProstoraToJson(
        RezervacijaProstora instance) =>
    <String, dynamic>{
      'rezervacijaProstoraId': instance.rezervacijaProstoraId,
      'oznaka': instance.oznaka,
      'kapacitet': instance.kapacitet,
      'aktivan': instance.aktivan,
      'datumIVrijemePocetkaRezervacije':
          instance.datumIVrijemePocetkaRezervacije?.toIso8601String(),
      'trajanje': instance.trajanje,
      'statusRezervacije': instance.statusRezervacije,
      'napomena': instance.napomena,
      'korisnikId': instance.korisnikId,
      'radniProstorId': instance.radniProstorId,
      'korisnik': instance.korisnik,
      'radniProstor': instance.radniProstor,
    };
