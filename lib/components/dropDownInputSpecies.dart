import 'package:flutter/material.dart';
import "package:pawstic/globals.dart" as globals;
import 'package:pawstic/model/specie.dart';
import "package:pawstic/service/createPublishService.dart"
    as createPublishService;

class DropDownInputSpecies extends StatefulWidget {
  final List<DropdownMenuItem<Specie>> dropdownSpecies;
  DropDownInputSpecies(this.dropdownSpecies);

  @override
  State<StatefulWidget> createState() =>
      DropDownInputSpeciesState(this.dropdownSpecies);
}

class DropDownInputSpeciesState extends State<DropDownInputSpecies> {
  List<DropdownMenuItem<Specie>> dropdownSpecies;
  DropDownInputSpeciesState(this.dropdownSpecies);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.0,
      height: 65.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: globals.fillGreyColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: createPublishService.specieSelected,
          items: dropdownSpecies,
          onChanged: (value) {
            setState(() {
              createPublishService.specieSelected = value;
            });
          },
          style: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 17.0,
              color: globals.titleColor),
        ),
      ),
    );
  }
}
