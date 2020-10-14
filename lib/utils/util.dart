import 'dart:math';

import 'package:flutter/material.dart';

class ConstKeys {
  static const deviceKey = 'device_size';
  static const roundAngelKey = 'round_angle_size';
  static const regularPolygonKey = 'regular_angle_size';
  static const circleKey = 'circle custom painter';
  static const circleTriangleKey = 'circle triangle painter';
  static const logoKey = 'logo_page_size';
}

//#region enums

enum BannerType {
  all,
  foodAndDrug,
  marketplace,
}

enum LocalityType { phoenix }

enum DialogActionType {
  agree,
  cancel,
  disagree,
  disregard,
}

enum CountryType {
  us,
}

enum CountyType {
  maricopa,
}

enum HTMLImageSizeType {
  small,
  medium,
  large,
  xlarge,
  thumbnail,
}

enum PerspectiveType {
  front,
  back,
  top,
  bottom,
  side,
}

enum UnitOfMeasureType {
  count, //ct
  unit,
  inch, //in
}

enum AdministrativeAreaType {
  az, // Arizona
}

enum TaxonomyType {
  retailSales,
  foodForHomeConsumption,
}

enum TemperatureIndicatorType { ambient }

//#endregion

class HTMLImage {
  HTMLImageSizeType size;
  String url;
}

class Measurement {
  double value;
  UnitOfMeasureType unitOfMeasure;
}

class TimeRangeOfDay {
  TimeOfDay start;
  TimeOfDay end;
  bool is24Hours;
}

//#endregion

class Calculator {
  static int nearestMultipleInt(double value, int multiple) {
    assert(value != null && multiple != null);
    final modular = value.round().toInt();
    multiple = multiple is int ? multiple : multiple.toInt();
    if (modular == 0 || multiple == 0) {
      return 0;
    }
    if ((modular % multiple) == 0.0) {
      return modular;
    }
    // small multiple boundary
    final a = ((modular / multiple) * multiple).round().toInt();
    // large multiple boundary
    final b = a + multiple;
    // result is the closest boundary to value
    return (modular - a > b - modular) ? b : a;
  }

  static double kilometerToMiles(double value) => value * 0.621371;
}

class EnumParser {
  static BannerType parseBannerType(String value) {
    assert(value != null && value.isNotEmpty);
    return BannerType.values.firstWhere((v) => v.toString() == value);
  }

  static T fromString<T>(Iterable<T> values, String stringType) {
    return values.firstWhere(
        (f) =>
            "${f.toString().substring(f.toString().indexOf('.') + 1)}"
                .toString()
                .toLowerCase() ==
            stringType.toLowerCase(),
        orElse: () => null);
  }

  static String enumValueToString<T>(T value) {
    assert(value != null);
    return value.toString().replaceFirst(RegExp(r"[A-Za-z0-9-_']+?\."), '');
  }
}

class CanvasDesigner {
  static final Map<String, CanvasDesigner> _keyValues = {};

  static void initDesignSize() {
    getInstance(key: ConstKeys.roundAngelKey).designSize = Size(500.0, 500.0);
    getInstance(key: ConstKeys.regularPolygonKey).designSize =
        Size(500.0, 500.0);
    getInstance(key: ConstKeys.logoKey).designSize = Size(580, 648.0);
    getInstance(key: ConstKeys.circleKey).designSize = Size(500.0, 500.0);
    getInstance(key: ConstKeys.circleTriangleKey).designSize =
        Size(500.0, 500.0);
  }

  //device pixel ratio.
  Size _designSize;

  //logic size in device
  Size _logicalSize;

  static CanvasDesigner getInstance({key = ConstKeys.deviceKey}) {
    if (_keyValues.containsKey(key)) {
      return _keyValues[key];
    } else {
      _keyValues[key] = CanvasDesigner();
      return _keyValues[key];
    }
  }

  set designSize(Size size) {
    _designSize = size;
  }

  double get width => _logicalSize.width;

  double get height => _logicalSize.height;

  set logicSize(Size size) => _logicalSize = size;

  double getAxisX(double designWidth) {
    return (designWidth * width) / _designSize.width;
  }

  // the y direction
  double getAxisY(double h) {
    return (h * height) / _designSize.height;
  }

  // diagonal direction value with design size s.
  double getAxisBoth(double s) {
    return s *
        sqrt((width * width + height * height) /
            (_designSize.width * _designSize.width +
                _designSize.height * _designSize.height));
  }
}
