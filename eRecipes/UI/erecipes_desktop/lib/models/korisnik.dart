import 'package:erecipes_desktop/models/uloga.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik{
  int? korisnikId;
  String? ime; 
  String? Prezime; 
  DateTime? datumRodjenja;
   String? email; 
  String? telefon; 
  String? korisnickoIme; 
  String? lozinka; 
  Uloga? uloga;
  String? uloge;

   Korisnik({
    this.ime,
    this.Prezime,
    this.datumRodjenja,
    this.email,
    this.telefon,
    this.korisnickoIme,
    this.lozinka,
    this.uloga,
    this.uloge
   });

  factory Korisnik.FromJson(Map<String,dynamic> json)=> _$KorisnikFromJson(json);

  Map<String,dynamic> toJson() => _$KorisnikToJson(this);
}