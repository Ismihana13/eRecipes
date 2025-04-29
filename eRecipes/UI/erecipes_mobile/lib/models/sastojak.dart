import 'package:json_annotation/json_annotation.dart';

part 'sastojak.g.dart';

@JsonSerializable()
class Sastojak{
  int? sastojakId;
  String? naziv; 
  String? kolicina; // Dodano
  int? mjernaJedinicaId; // Dodano
 
  Sastojak({this.naziv,this.sastojakId});

 factory Sastojak.FromJson(Map<String,dynamic> json)=> _$SastojakFromJson(json);

 Map<String,dynamic> toJson() => _$SastojakToJson(this);
}