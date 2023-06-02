import 'package:flutter/material.dart';

import '../../furniture_viewmodel.dart';

class FurnitureThirdView extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const FurnitureThirdView({
    Key? key,
    required this.furnitureViewModel,
  }) : super(key: key);

  @override
  _FurnitureThirdViewState createState() => _FurnitureThirdViewState();
}

class _FurnitureThirdViewState extends State<FurnitureThirdView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
