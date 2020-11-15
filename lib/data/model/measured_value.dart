import 'package:ishop/data/enums/unit_of_measure.dart';

class MeasuredValue {
  const MeasuredValue(this.value, this.unitOfMeasure);
  final double value;
  final UnitOfMeasurement unitOfMeasure;
}
