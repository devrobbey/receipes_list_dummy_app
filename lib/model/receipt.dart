import 'package:equatable/equatable.dart';

class Receipt extends Equatable {
  const Receipt(this.id, this.name, this.subtitle, this.ingredients, this.steps);

  final String id;
  final String name;
  final String subtitle;
  final Set<String> ingredients;
  final List<String> steps;

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "subtitle": subtitle,
      "ingredients": ingredients,
      "steps": steps,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        subtitle,
        ingredients,
        steps,
      ];
}
