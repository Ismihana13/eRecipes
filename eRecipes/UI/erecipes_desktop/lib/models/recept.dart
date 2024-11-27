import 'package:json_annotation/json_annotation.dart';

part 'recept.g.dart';

@JsonSerializable()
class Recept{
  int? receptId;
  String? naziv; 
  String? slika;
  int? vrstaId;
  int? korisnikId;

  Recept({this.receptId, this.naziv});

  factory Recept.FromJson(Map<String,dynamic> json)=> _$ReceptFromJson(json);

  Map<String,dynamic> toJson() => _$ReceptToJson(this);
}