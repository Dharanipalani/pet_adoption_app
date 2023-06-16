import 'package:flutter/material.dart';
import 'package:pet_adoption_app/logic/models/pet_model.dart';
import 'package:pet_adoption_app/presentation/screens/detail_screen.dart';

class PetCardWidget extends StatefulWidget {
  final PetModel petModel;
  //ignore: prefer_const_constructors_in_immutables
  PetCardWidget({
    required this.petModel,
    Key? key,
  }) : super(key: key);

  @override
  State<PetCardWidget> createState() => _PetCardWidgetState();
}

class _PetCardWidgetState extends State<PetCardWidget> {
  double? availableWidth;

  callback(newAdoptedStatus) {
    if (this.mounted) {
      setState(() {
        widget.petModel.adoptionStatus = newAdoptedStatus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PetDetailsScreen(
                  title: widget.petModel.petName,
                  petModel: widget.petModel,
                  callback: callback)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Theme.of(context).cardColor,
        shadowColor: Theme.of(context).shadowColor,
        elevation: 50.0,
        margin: const EdgeInsets.only(top: 10, left: 24, right: 24),

        // To make use of available width based on the different size of devices.
        child: LayoutBuilder(builder: (context, constraints) {
          availableWidth = constraints.maxWidth;
          return SizedBox(
            height: 140,
            width: constraints.maxWidth,
            child: Row(
              children: [
                Hero(
                  tag: widget.petModel.petId.toString() +
                      widget.petModel.petName,
                  child: Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(widget.petModel.petImage!,
                          width: 100, height: 100, fit: BoxFit.fitHeight),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.petModel.petName,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Container(
                        width: 40.7 / 100 * availableWidth!,
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 18,
                            ),
                            Expanded(
                              child: Text(
                                widget.petModel.petLocation,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 40.7 / 100 * availableWidth!,
                        child: Row(
                          children: [
                            const Text(
                              'Origin: ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(
                              child: Text(
                                widget.petModel.petOrigin,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 40.7 / 100 * availableWidth!,
                        child: Row(
                          children: [
                            Text(
                              widget.petModel.petSex + ' | ',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Expanded(
                              child: Text(
                                widget.petModel.petAge,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 12, right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: widget.petModel.adoptionStatus,
                        child: Container(
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Adopted',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.petModel.petPrice,
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
