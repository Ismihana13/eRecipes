import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/radni_prostor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_prostora.g.dart';

@JsonSerializable()
class RezervacijaProstora {
  int? rezervacijaProstoraId;
  String? oznaka;
  int? kapacitet;
  bool? aktivan;
  DateTime? datumIVrijemePocetkaRezervacije;
  int? trajanje;
  String? statusRezervacije;
  String? napomena;
  int? korisnikId;
  int? radniProstorId;
  Korisnik? korisnik;
  RadniProstor? radniProstor;
  
  RezervacijaProstora({
    this.rezervacijaProstoraId,
    this.oznaka,
    this.kapacitet,
    this.aktivan,
    this.datumIVrijemePocetkaRezervacije,
    this.trajanje,
    this.statusRezervacije,
    this.napomena,
    this.korisnikId,
    this.radniProstorId,
    this.korisnik,
    this.radniProstor,
  });

  factory RezervacijaProstora.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaProstoraFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaProstoraToJson(this);
}
