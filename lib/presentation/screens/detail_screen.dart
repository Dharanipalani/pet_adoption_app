import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../logic/models/pet_model.dart';

//ignore: must_be_immutable
class PetDetailsScreen extends StatefulWidget {
  final String title;
  final PetModel petModel;
  Function(bool) callback;

  PetDetailsScreen(
      {required this.title,
      required this.petModel,
      required this.callback,
      Key? key})
      : super(key: key);

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  final _confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  double _screenWidth = 0.0, _screenHeight = 0.0;
  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 32, color: Theme.of(context).iconTheme.color),
            ),
            iconTheme: Theme.of(context).iconTheme,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(children: [
            Stack(
              children: [
                Card(
                  shadowColor: Colors.grey,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  elevation: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(children: [
                      Hero(
                          tag: widget.petModel.petId.toString() +
                              widget.petModel.petName,
                          child: Container(
                              // using height in percentage so, it will
                              // be same for all screen size.
                              width: _screenWidth,
                              height: 27.6 / 100 * _screenHeight,
                              margin: const EdgeInsets.all(8),
                              // using this to clipping the image while zooming
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                // using photo view package for zooming feature
                                child: PhotoView(
                                  customSize: Size(
                                      MediaQuery.of(context).size.width,
                                      30 / 100 * _screenHeight),
                                  imageProvider: Image.asset(
                                          widget.petModel.petImage!,
                                          fit: BoxFit.fitHeight)
                                      .image,
                                ),
                              ))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.petModel.petName,
                                  style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 1.18 / 100 * _screenHeight),
                                Row(
                                  children: [
                                    const Text(
                                      'Origin: ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      widget.petModel.petLocation,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(height: 1.18 / 100 * _screenHeight),
                                Row(
                                  children: [
                                    Text(
                                      widget.petModel.petSex + ' | ',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.petModel.petAge,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Column(
                              children: [
                                Text(
                                  widget.petModel.petPrice,
                                  style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                SizedBox(height: 1.18 / 100 * _screenHeight),
                                HeightAndWeightWidget(
                                    labelName: 'Height: ',
                                    value: widget.petModel.petHeight!),
                                SizedBox(height: 1.18 / 100 * _screenHeight),
                                HeightAndWeightWidget(
                                    labelName: 'Weight: ',
                                    value: widget.petModel.petWeight!),
                              ],
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                ),
              ],
            ),
            Card(
                clipBehavior: Clip.hardEdge,
                shadowColor: Theme.of(context).shadowColor,
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                elevation: 50.0,
                child: SizedBox(
                  width: _screenWidth,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 12, top: 12, bottom: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Image.asset('assets/women.jpg',
                                width: 80, height: 80, fit: BoxFit.fitHeight),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0, right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Alexa',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                'Pet Owner',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on_outlined),
                                    Expanded(
                                      child: Text(
                                        widget.petModel.petLocation,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.call,
                            size: 30,
                          ),
                          onPressed: () {
                            _makingCall('7010658767');
                          },
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.sms,
                              color: Theme.of(context).iconTheme.color,
                              size: 30,
                            ),
                            onPressed: () {
                              _sendingSms('7010658767');
                            }),
                        IconButton(
                          icon: const Icon(
                            Icons.mail,
                            size: 30,
                          ),
                          onPressed: () {
                            _sendingMail('pdharanipalani@gmail.com');
                          },
                        )
                      ]),
                )),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: Text('Details',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16),
              child: SizedBox(
                height: 50,
                child: Text(
                    'It is really a very helpful pet animal. He respects his owner from the heart and can easily guess his/ her presence through their smell',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
              child: ElevatedButton(
                clipBehavior: Clip.hardEdge,
                onPressed: () => widget.petModel.adoptionStatus
                    ? null
                    : _showAlertDialog(context, _confettiController),
                style: widget.petModel.adoptionStatus
                    ? ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ))
                    : ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: const Text(
                    'Adopt Me',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ),
            )
          ]),
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 30,
          emissionFrequency: 0.5,
          minBlastForce: 10,
          maxBlastForce: 50,
        ),
      ],
    );
  }

  _showAlertDialog(
      BuildContext context, ConfettiController confettiController) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Pet adopt',
            style: TextStyle(fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Are you sure want to adopt this pet ?',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () => _showSimpleDialog(context, confettiController),
            ),
          ],
        );
      },
    );
  }

  _showSimpleDialog(
      BuildContext context, ConfettiController confettiController) async {
    confettiController.play();
    await Future.delayed(const Duration(milliseconds: 200));
    confettiController.stop();
    final prefs = await SharedPreferences.getInstance();
    // To rebuild the card state to mark it as adapted.
    widget.callback(widget.petModel.adoptionStatus = true);
    setState(() {
      widget.petModel.adoptionStatus = true;
      // storing the adopted status in shared preferences
      // to maintain the state of the app across the app launches
      prefs.setBool(
          widget.petModel.petName, widget.petModel.adoptionStatus = true);
    });
    Navigator.pop(context);

    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: Theme.of(context).dialogBackgroundColor,
              clipBehavior: Clip.hardEdge,
              elevation: 50,
              title: const Text('Congratulations!!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: const Icon(
                    Icons.check_circle_sharp,
                    size: 50,
                    color: Colors.green,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 36.0, right: 12, bottom: 12),
                  child: Container(
                    child: (Text(
                      'You '
                      '\'ve '
                      'now adopted ${widget.petModel.petName}'
                      ' !!!',
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Container(
                      child: (ElevatedButton(
                    clipBehavior: Clip.hardEdge,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: const Text(
                        'Okay',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ),
                  ))),
                ),
              ]);
        });
  }
}

_sendingMail(String mailId) async {
  String url = 'mailto:$mailId';
  await launchUrl(Uri.parse(url));
}

_makingCall(String mobileNumber) async {
  String url = 'tel:$mobileNumber';
  await launchUrl(Uri.parse(url.trim()));
}

_sendingSms(String mobileNumber) async {
  String url = 'sms:$mobileNumber';
  await launchUrl(Uri.parse(url.trim()));
}

class HeightAndWeightWidget extends StatelessWidget {
  const HeightAndWeightWidget(
      {Key? key, required this.labelName, required this.value})
      : super(key: key);

  final String labelName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          labelName,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
