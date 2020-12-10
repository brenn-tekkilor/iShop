import 'package:flutter/material.dart';

/// SpacerWidget
class SpacerWidget {
  // Vertical spacing constants. Adjust to your liking.
  static const double _verticalSpaceSmall = 10;
  static const double _verticalSpaceMedium = 20;
  static const double _verticalSpaceLarge = 60;

  // Vertical spacing constants. Adjust to your liking.
  static const double _horizontalSpaceSmall = 10;
  static const double _horizontalSpaceMedium = 20;
  static const double _horizontalSpaceLarge = 60;

  /// Returns a vertical space with height set to [_verticalSpaceSmall]
  static Widget verticalSpaceSmall() => verticalSpace(_verticalSpaceSmall);

  /// Returns a vertical space with height set to [_verticalSpaceMedium]
  static Widget verticalSpaceMedium() => verticalSpace(_verticalSpaceMedium);

  /// Returns a vertical space with height set to [_verticalSpaceLarge]
  static Widget verticalSpaceLarge() => verticalSpace(_verticalSpaceLarge);

  /// Returns a vertical space equal to the [height] supplied
  static Widget verticalSpace(double height) => Container(height: height);

  /// Returns a vertical space with height set to [_horizontalSpaceSmall]
  static Widget horizontalSpaceSmall() =>
      horizontalSpace(_horizontalSpaceSmall);

  /// Returns a vertical space with height set to [_horizontalSpaceMedium]
  static Widget horizontalSpaceMedium() =>
      horizontalSpace(_horizontalSpaceMedium);

  /// Returns a vertical space with height set to [_horizontalSpaceLarge]
  static Widget horizontalSpaceLarge() =>
      horizontalSpace(_horizontalSpaceLarge);

  /// Returns a vertical space equal to the [width] supplied
  static Widget horizontalSpace(double width) => Container(width: width);
}
