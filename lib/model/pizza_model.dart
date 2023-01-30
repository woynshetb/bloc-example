import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Pizza extends Equatable {
  final String name;
  final String id;
  final Image image;

  const Pizza(this.name, this.id, this.image);

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];

  static List<Pizza> pizzas = [
    Pizza(
      "Mocorroni",
      "1",
      Image.asset("assets/neymar.png"),
    ),
    Pizza(
      "Neymar",
      "2",
      Image.asset("assets/neymar.png"),
    ),
  ];
}
