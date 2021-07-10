import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category{
  final int id;
  final String name;
  final dynamic icon;
  Category(this.id, this.name, {this.icon});

}

final List<Category> categories = [
  Category(9,"GK", icon: FontAwesomeIcons.globeAsia),
  Category(16,"Games", icon: FontAwesomeIcons.chessBoard),
  Category(17,"Nature,Science and Technology", icon: FontAwesomeIcons.microscope),
  Category(18,"Computers and its Fundamentals", icon: FontAwesomeIcons.laptopCode),
  Category(19,"Mathematics", icon: FontAwesomeIcons.sortNumericDown),
  Category(21,"Sports", icon: FontAwesomeIcons.footballBall),
  Category(22,"Geographical and Global Knowledge", icon: FontAwesomeIcons.mountain),
  Category(23,"History and Ancient Knowledge", icon: FontAwesomeIcons.monument),
  Category(26,"Famous Personalities"),
  Category(27,"Animals and Wildlife", icon: FontAwesomeIcons.dog),
  Category(28,"Vehicles", icon: FontAwesomeIcons.carAlt),
  Category(30,"Gadgets and Electronics", icon: FontAwesomeIcons.mobileAlt),
  Category(32,"Comic Stories"),
  Category(31, "Anime")
];