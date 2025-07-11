
import 'package:erecipes_mobile/models/kategorija_transakcije14072025.dart';
import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transakcija14072025.g.dart';

@JsonSerializable()
class Transakcija14072025 {
  int? transakcija14072025Id;
 int? korisnikId;
 Korisnik? korisnik;
 int? kategorijaTransakcije14072025Id;
 KategorijaTransakcije14072025? kategorijaTransakcije14072025;
 double? iznos;
 DateTime? datumTransakcije;
 String? opis;
 String? status;

  Transakcija14072025(
    this.korisnikId,
    this.iznos,
    this.datumTransakcije,
    this.opis,
    this.kategorijaTransakcije14072025Id,
    this.status
  );

  factory Transakcija14072025.FromJson(Map<String, dynamic> json) =>
     _$Transakcija14072025FromJson(json);

  Map<String, dynamic> toJson() => _$Transakcija14072025ToJson(this);
}
