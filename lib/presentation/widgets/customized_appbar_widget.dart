import 'package:flutter/material.dart';

import 'package:pet_adoption_app/logic/models/pet_model.dart';
import 'package:pet_adoption_app/presentation/widgets.dart';

class CustomizedAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget icon;
  final List<PetModel>? pets;
  const CustomizedAppBar(
      {Key? key, required this.title, required this.icon, this.pets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: icon,
          onPressed: () {
            showSearch(
                context: context,
                delegate: PetSearch(
                  pets: pets!,
                ));
          },
        ),
      ],
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 32,
            color: Theme.of(context).iconTheme.color,
            fontWeight: FontWeight.bold,
            fontFamily: 'avenir',
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class PetSearch extends SearchDelegate {
  List<PetModel> pets = [];
  PetSearch({required this.pets});
  String? queryString;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query == '') {
              close(context, null);
            }
            query = '';
          },
          icon: const Icon(
            Icons.clear,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<PetModel> matchQuery = [];
    queryString = query;

    for (var pet in pets) {
      if (pet.petName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(pet);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return PetCardWidget(petModel: matchQuery[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PetModel> matchQuery = [];
    queryString = query;

    for (var pet in pets) {
      if (pet.petName.toLowerCase().startsWith(query.toLowerCase())) {
        matchQuery.add(pet);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return PetCardWidget(petModel: matchQuery[index]);
        });
  }
}
