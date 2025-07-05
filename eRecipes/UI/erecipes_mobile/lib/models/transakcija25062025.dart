import 'package:erecipes_mobile/models/kategorija_transakcije25062025.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:erecipes_mobile/models/korisnik.dart';

part 'transakcija25062025.g.dart';

@JsonSerializable()
class Transakcija25062025 {
  int? transakcija25062025Id;
  int? korisnikId;
  double? iznos;
  DateTime? datumTransakcije;
  String? opis;
  int? kategorijaTransakcije25062025Id;
  String? status;
  Korisnik? korisnik;
  KategorijaTransakcije25062025? kategorijaTransakcije25062025;

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
//
   Map<String, dynamic> toJson() => _$Transakcija25062025ToJson(this);
}
