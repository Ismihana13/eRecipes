

import 'package:erecipes_mobile/models/korisnik.dart';
import 'package:erecipes_mobile/models/recept_sastojak.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recept.g.dart';

@JsonSerializable()
class Recept{
  int? receptId;
  String? naziv; 
  String? slika;
  int? vrstaJelaId;
  int? kategorijaId;
  int? vrijemePripreme;
  int? korisnikId;
  bool? premium;
  String? stateMachine;
  String? opisRecepta;
  DateTime? datumObjave;
  String? opisPripreme;
  List<ReceptSastojak>? sastojci;
  Korisnik? korisnik;
  bool? isFavorite;
  List<String>? sastojcii;
   Recept({
    required this.naziv,
    required this.opisRecepta,
    required this.opisPripreme,
    required this.vrijemePripreme,
    this.kategorijaId,
    this.vrstaJelaId,
    this.slika,
  });

  factory Recept.FromJson(Map<String,dynamic> json)=> _$ReceptFromJson(json);

  Map<String,dynamic> toJson() => _$ReceptToJson(this);
}