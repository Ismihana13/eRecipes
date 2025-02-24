import 'package:erecipes_desktop/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';

part 'obavijest.g.dart';

@JsonSerializable()
class Obavijest {
  int? obavijestId;
  String? naslov; 
  String? sadrzaj;
  int? korisnikId;
  Korisnik? korisnik;
  DateTime? datumSlanja;
  bool? procitano;
  
     Obavijest({
    this.obavijestId,
    this.naslov,
    this.sadrzaj,
    this.korisnikId,
    this.korisnik,
    this.datumSlanja,
    this.procitano,
  });
  
  factory Obavijest.FromJson(Map<String,dynamic> json)=> _$ObavijestFromJson(json);

  Map<String,dynamic> toJson() => _$ObavijestToJson(this);
}