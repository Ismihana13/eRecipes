import 'package:erecipes_mobile/models/recept.dart';
import 'package:json_annotation/json_annotation.dart';

part 'omiljeni_recept.g.dart';

@JsonSerializable()
class OmiljeniRecept{
  int? omiljeReceptId;
  int? korisnikId;
  int? receptId;
  DateTime? datumDodavanja;
  Recept? recept;
  
   OmiljeniRecept();
  
 factory OmiljeniRecept.FromJson(Map<String,dynamic> json)=> _$OmiljeniReceptFromJson(json);

  Map<String,dynamic> toJson() => _$OmiljeniReceptToJson(this);
}