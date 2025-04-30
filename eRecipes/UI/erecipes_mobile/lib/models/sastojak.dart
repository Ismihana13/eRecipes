import 'package:json_annotation/json_annotation.dart';

part 'sastojak.g.dart';

@JsonSerializable()
class Sastojak{
  int? sastojakId;
  String? naziv; 
  String? kolicina; 
  int? mjernaJedinicaId; 
  String? nazivMjerneJedinice;
 
 Sastojak({
  this.sastojakId,
  this.naziv,
  this.kolicina,
  this.mjernaJedinicaId,
  this.nazivMjerneJedinice,
});

 factory Sastojak.FromJson(Map<String,dynamic> json)=> _$SastojakFromJson(json);

 Map<String,dynamic> toJson() => _$SastojakToJson(this);
}