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
      padding: const EdgeInsets.all(Dimensions.placeItemPadding),
      decoration: const BoxDecoration(
        color: Colors.amberAccent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.placeItemBorderRadius),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(place.image),
        ),
        title: Text(place.title),
        onTap: onClick,
      ),
    );
  }
}
