import 'package:flutter/material.dart';

import 'package:pet_adoption_app/logic/models/pet_model.dart';
import 'package:pet_adoption_app/presentation/widgets.dart';

class HistoryScreen extends StatefulWidget {
  final List<PetModel> adoptedPets;
  const HistoryScreen({Key? key, required this.adoptedPets}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          'History',
          style: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: widget.adoptedPets.isNotEmpty
          ? ListView.builder(
              itemBuilder: ((context, index) {
                return PetCardWidget(petModel: widget.adoptedPets[index]);
              }),
              itemCount: widget.adoptedPets.length,
            )
          : const Center(
              child: Text(
              'No Pets are adopted',
              style: TextStyle(fontSize: 32),
            )),
    );
  }
}
