import 'package:json_annotation/json_annotation.dart';

part 'vrsta_jela.g.dart';

@JsonSerializable()
class VrstaJela{
  int? vrstaJelaId;
  String? naziv; 
  int? brojRecepata;
  
   VrstaJela();
  
  factory VrstaJela.FromJson(Map<String,dynamic> json)=> _$VrstaJelaFromJson(json);

  Map<String,dynamic> toJson() => _$VrstaJelaToJson(this);
}