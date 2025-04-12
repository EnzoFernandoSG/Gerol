class Plant {
  final String name;
  final String description;
  final String region;
  final String light;
  final String watering;
  final String soil;

  Plant({
    required this.name,
    required this.description,
    required this.region,
    required this.light,
    required this.watering,
    required this.soil,
  });

  // Converte a planta para JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'region': region,
      'light': light,
      'watering': watering,
      'soil': soil,
    };
  }

  // Cria uma planta a partir de JSON
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      name: json['name'],
      description: json['description'],
      region: json['region'],
      light: json['light'],
      watering: json['watering'],
      soil: json['soil'],
    );
  }
}