class Exercise {
  final int id;
  final String name;
  final String description;
  final String? imageUrl;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      imageUrl: json['image'] as String?,
    );
  }
}
