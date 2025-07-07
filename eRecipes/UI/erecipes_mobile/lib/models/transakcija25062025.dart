import 'package:erecipes_mobile/models/kategorija_transakcije25062025.dart';
import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transakcija25062025.g.dart';

@JsonSerializable()
class Transakcija25062025 {
  int? transakcija25062025Id;
  double? iznos;
  DateTime? datumTransakcije;
  String? opis;
  int? korisnikId;
  String? status;
  Korisnik? korisnik;
  KategorijaTransakcije25062025? kategorijaTransakcije25062025;
  int? kategorijaTransakcije25062025Id;

  Transakcija25062025(
    this.korisnikId,
    this.iznos,
    this.datumTransakcije,
    this.opis,
    this.kategorijaTransakcije25062025Id,
    this.status

  );

  factory Transakcija25062025.FromJson(Map<String, dynamic> json) =>
     _$Transakcija25062025FromJson(json);

  Map<String, dynamic> toJson() => _$Transakcija25062025ToJson(this);
}
