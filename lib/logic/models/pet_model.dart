class PetModel {
  PetModel(
      {required this.petName,
      required this.petId,
      required this.petLocation,
      required this.petOrigin,
      required this.petSex,
      required this.petAge,
      required this.petPrice,
      this.petDetails,
      this.petImage,
      this.petHeight,
      this.petWeight,
      this.adoptionStatus = false});

  final String petName;
  final int petId;
  final String petLocation;
  final String petOrigin;
  final String petSex;
  final String petAge;
  final String? petHeight;
  final String? petWeight;
  final String petPrice;
  final String? petDetails;
  final String? petImage;
  bool adoptionStatus;
}
