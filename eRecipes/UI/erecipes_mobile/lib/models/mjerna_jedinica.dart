import 'package:json_annotation/json_annotation.dart';

part 'mjerna_jedinica.g.dart';

@JsonSerializable()
class MjernaJedinica{
  int? mjernaJedinicaId;
  String? naziv; 
  String? oznaka; 

   MjernaJedinica();
  
  factory MjernaJedinica.FromJson(Map<String,dynamic> json)=> _$MjernaJedinicaFromJson(json);

  Map<String,dynamic> toJson() => _$MjernaJedinicaToJson(this);
}