import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.yellow,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              'Loading...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
