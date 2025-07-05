// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transakcija_log25062025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransakcijaLog25062025 _$TransakcijaLog25062025FromJson(
        Map<String, dynamic> json) =>
    TransakcijaLog25062025()
      ..transakcijaLog25062025Id =
          (json['transakcijaLog25062025Id'] as num?)?.toInt()
      ..staraVrijednost = json['staraVrijednost'] as String?
      ..novaVrijednost = json['novaVrijednost'] as String?
      ..vrijemePromjene = json['vrijemePromjene'] == null
          ? null
          : DateTime.parse(json['vrijemePromjene'] as String)
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>)
      ..KorisnikId = (json['KorisnikId'] as num?)?.toInt();

Map<String, dynamic> _$TransakcijaLog25062025ToJson(
        TransakcijaLog25062025 instance) =>
    <String, dynamic>{
      'transakcijaLog25062025Id': instance.transakcijaLog25062025Id,
      'staraVrijednost': instance.staraVrijednost,
      'novaVrijednost': instance.novaVrijednost,
      'vrijemePromjene': instance.vrijemePromjene?.toIso8601String(),
      'korisnik': instance.korisnik,
      'KorisnikId': instance.KorisnikId,
    };
