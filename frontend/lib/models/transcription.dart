import 'dart:convert';

class Entity {
  final String entityType;
  final String text;
  final int start;
  final int end;

  Entity({
    required this.entityType,
    required this.text,
    required this.start,
    required this.end,
  });

  // Convert Entity object to a Map
  Map<String, dynamic> toMap() {
    return {
      'entity_type': entityType,
      'text': text,
      'start': start,
      'end': end,
    };
  }

  // Create an Entity object from a Map
  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity(
      entityType: map['entity_type'] ?? '',
      text: map['text'] ?? '',
      start: map['start'] ?? 0,
      end: map['end'] ?? 0,
    );
  }

  // Convert Entity object to JSON
  String toJson() => json.encode(toMap());

  // Create an Entity object from JSON
  factory Entity.fromJson(String source) => Entity.fromMap(json.decode(source));
}

class Transcription {
  final int id;
  final String audioLink;
  final List<Entity> entities;

  Transcription({
    required this.id,
    required this.audioLink,
    required this.entities,
  });

  // Convert Transcription object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'audioLink': audioLink,
      'entities': entities.map((entity) => entity.toMap()).toList(),
    };
  }

  // Create a Transcription object from a Map
  factory Transcription.fromMap(Map<String, dynamic> map) {
    return Transcription(
      id: map['id'] ?? 0,
      audioLink: map['audioLink'] ?? '',
      entities: (jsonDecode(map['entities']) as List<dynamic>)
          .map((item) => Entity.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // Convert Transcription object to JSON
  String toJson() => json.encode(toMap());

  // Create a Transcription object from JSON
  factory Transcription.fromJson(String source) => Transcription.fromMap(json.decode(source));
}
