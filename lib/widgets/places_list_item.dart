import 'package:flutter/material.dart';
import 'package:great_places/data/models/place.dart';
import 'package:great_places/utils/dimensions.dart';

class PlacesListItem extends StatelessWidget {
  final Place place;
  final VoidCallback onClick;

  const PlacesListItem(
    this.place,
    this.onClick, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimensions.placesItemTopMargin,
      ),
      child: ListTile(
        visualDensity: VisualDensity.standard,
        tileColor: Colors.amberAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.placeItemBorderRadius),
          ),
        ),
        minVerticalPadding: Dimensions.placeItemPadding,
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: FileImage(place.image),
        ),
        title: Text(place.title),
        subtitle: Text(
          place.location.address,
          maxLines: 1,
        ),
        onTap: onClick,
      ),
    );
  }
}
