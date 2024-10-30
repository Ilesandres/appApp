class Language {
  final String id;
  final String name;
  final String description;
  final String audioUrl; // URL del audio de pronunciación
  final String imageUrl; // URL de la imagen representativa

  Language({
    required this.id,
    required this.name,
    required this.description,
    required this.audioUrl,
    required this.imageUrl,
  });
}