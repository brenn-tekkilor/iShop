import 'package:ishop/data/enums/unit_of_measure.dart';

/// MeasuredValue
class MeasuredValue {
  /// MeasuredValue constructor
  const MeasuredValue(this.value, this.unitOfMeasure);

  /// value
  final double value;

  /// unitOfMeasure
  final UnitOfMeasurement unitOfMeasure;
}
