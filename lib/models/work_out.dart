class Workout {
  final String name;
  final int duration; // Duration in minutes

  Workout({
    required this.name,
    required this.duration,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'duration': duration,
  };

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      name: json['name'],
      duration: json['duration'],
    );
  }
}
