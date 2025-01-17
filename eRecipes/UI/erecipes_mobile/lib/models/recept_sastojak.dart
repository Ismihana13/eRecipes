import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/sastojak.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recept_sastojak.g.dart';

@JsonSerializable()
class ReceptSastojak{
  int? receptSastojakId;
  int? receptId; 
 int? sastojakId;
double? kolicina;
String? mjernaJedinica;
Recept? recept;
Sastojak? sastojak; 
  ReceptSastojak();

 factory ReceptSastojak.FromJson(Map<String,dynamic> json)=> _$ReceptSastojakFromJson(json);

 Map<String,dynamic> toJson() => _$ReceptSastojakToJson(this);
}