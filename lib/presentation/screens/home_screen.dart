import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../logic/blocs/bloc/theme_bloc.dart';
import '../../logic/models/pet_mock_data.dart';
import '../../logic/models/pet_model.dart';
import '../widgets/customized_appbar_widget.dart';
import '../widgets/pet_card_widget.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PetModel> pets = [];
  List<PetModel> adoptedPets = [];
  bool themeState = false;

  @override
  void initState() {
    super.initState();
  }

  Future<List<PetModel>> getPets() async {
    // Read the old values and set the status
    // for the adopted pets
    final prefs = await SharedPreferences.getInstance();

    for (int index = 0; index < 24; index++) {
      pets.add(PetModel(
          petName: petNames[index],
          petId: index,
          petLocation: petLocations[index],
          petOrigin: petOrigins[index],
          petSex: petSex[index],
          petAge: petAge[index],
          petPrice: petPrice[index],
          petImage: petImages[index],
          petHeight: petHeights[index],
          petWeight: petWeights[index],
          adoptionStatus: prefs.getBool(petNames[index]) ?? false));
    }

    return pets;
  }

  getAdoptedPets() {
    adoptedPets = [];
    for (int index = 0; index < pets.length; index++) {
      if (pets[index].adoptionStatus) {
        adoptedPets.add(pets[index]);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HistoryScreen(
                adoptedPets: adoptedPets,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Container(
            margin: const EdgeInsets.only(top: kToolbarHeight + 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.dark_mode),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Change Theme',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Switch(
                      value: themeState,
                      onChanged: (value) {
                        themeState = value;
                        BlocProvider.of<ThemeBloc>(context).add(ChangeTheme());
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: getAdoptedPets,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.history),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('History of pets',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: CustomizedAppBar(
          title: 'Pet Shop',
          pets: pets,
          icon: Container(
            margin: const EdgeInsets.only(right: 12),
            child: const Icon(
              Icons.search,
            ),
          ),
        ),
        body: FutureBuilder(
            future: getPets(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 24,
                  itemBuilder: ((context, index) {
                    return PetCardWidget(
                      petModel: pets[index],
                    );
                  }),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
