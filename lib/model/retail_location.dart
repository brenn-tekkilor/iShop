import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/utils/styles.dart';
import 'package:ishop/utils/util.dart';

enum RetailLocationBannerType {
  frysMarketplace,
  frysFoodAndDrug,
  frysSignature,
}

class AisleLocation {
  AisleLocation(this.id,
      {this.bayNumber,
      this.description,
      this.number,
      this.numberOfFacings,
      this.sequenceNumber,
      this.side,
      this.shelfNumber,
      this.shelfPositionInBay});

  String id;
  int bayNumber;
  String description;
  int number;
  int numberOfFacings;
  int sequenceNumber;
  String side;
  int shelfNumber;
  int shelfPositionInBay;
}

class RetailLocation {
  //#region constructors: RetailLocation, RetailLocation.fromDoc
  //#region RetailLocation
  RetailLocation(
    this.id,
    this.address,
    this.phone, {
    this.position,
    this.banner,
    this.name,
    this.hoursOfOperationId,
    this.departmentIds,
  });
  //#endregion
  //#region RetailLocation.fromDoc
  RetailLocation.fromDoc(DocumentSnapshot doc) {
    id = doc.id;
    final data = doc.data();
    address = Address.fromMap(data['a']);
    position = Position(latitude: data['g']['a'], longitude: data['g']['o']);
    banner = data['b'];
    name = data['n'];
    hoursOfOperationId = data['h'];
    phone = data['p'];
    departmentIds = data['d'];
  }

  //#endregion
  //#endregion
  //#region properties
  String id;
  Address address;
  Position position;
  RetailLocationBannerType banner;
  String name;
  String hoursOfOperationId;
  String phone;
  List<String> departmentIds;
  Marker marker;
  //#endregion

  ListTile toListTile() {
    return ListTile(
        key: ValueKey(id),
        title: Text(name, style: AppStyles.primaryTextTheme.headline5),
        subtitle: Text(
          id,
          style: AppStyles.primaryTextTheme.bodyText1,
        ));
  }
}

class RetailDepartment {
  RetailDepartment(this.id, this.name);
  String id;
  String name;
}
