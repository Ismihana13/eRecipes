import 'package:erecipes_desktop/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifikacije.g.dart';

@JsonSerializable()
class Notifikacije{
  int? notifikacijeId;
  String? naslov; 
  String? sadrzaj;
  int? korisnikId;
  Korisnik? korisnik;
  DateTime? datumSlanja;
  bool? procitano;
  
     Notifikacije({
    this.notifikacijeId,
    this.naslov,
    this.sadrzaj,
    this.korisnikId,
    this.korisnik,
    this.datumSlanja,
    this.procitano,
  });
  
  factory Notifikacije.FromJson(Map<String,dynamic> json)=> _$NotifikacijeFromJson(json);

  Map<String,dynamic> toJson() => _$NotifikacijeToJson(this);
}