import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/styles/styles.dart';

class BasicTile extends StatelessWidget {
  const BasicTile({
    this.child,
    this.color,
    this.splashColor,
    this.onTap,
  });
  final Widget child;
  final Color color;
  final Color splashColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Material(
        color: color,
        elevation: 10.0,
        borderRadius: BorderRadius.circular(15.0),
        shadowColor: AppStyles.appColors['lightShadowColor'],
        child: InkWell(
          child: child,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(15.0),
          onTap: onTap == null ? () => {} : () => onTap(),
        ),
      ),
    );
  }
}
