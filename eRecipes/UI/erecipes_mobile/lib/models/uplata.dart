import 'package:json_annotation/json_annotation.dart';

part 'uplata.g.dart';

@JsonSerializable()
class Uplata{
  int? uplataId;
  double? iznos; 
  int? korisnikId;
  DateTime? datumUplate;
  
   Uplata();
  
  factory Uplata.FromJson(Map<String,dynamic> json)=> _$UplataFromJson(json);

  Map<String,dynamic> toJson() => _$UplataToJson(this);
}