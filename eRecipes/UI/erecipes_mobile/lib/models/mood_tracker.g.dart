// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoodTracker _$MoodTrackerFromJson(Map<String, dynamic> json) => MoodTracker(
      (json['korisnikId'] as num?)?.toInt(),
      json['vrijednostRaspolozenja'] as String?,
      json['opis'] as String?,
      json['datumEvidencije'] == null
          ? null
          : DateTime.parse(json['datumEvidencije'] as String),
    )
      ..moodTrackerId = (json['moodTrackerId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.FromJson(json['korisnik'] as Map<String, dynamic>);

Map<String, dynamic> _$MoodTrackerToJson(MoodTracker instance) =>
    <String, dynamic>{
      'moodTrackerId': instance.moodTrackerId,
      'vrijednostRaspolozenja': instance.vrijednostRaspolozenja,
      'opis': instance.opis,
      'datumEvidencije': instance.datumEvidencije?.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
    };
