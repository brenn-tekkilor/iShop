import 'package:flutter/material.dart';

///basic image asset
class ImageAsset extends StatelessWidget {
  /// basic image asset const constructor
  const ImageAsset({Key? key, String path = '', BoxFit fit = BoxFit.cover})
      : _path = path,
        _fit = fit,
        super(key: key);
  final String _path;
  final BoxFit _fit;
  @override
  Widget build(BuildContext context) => Image.asset(_path, fit: _fit);
}
