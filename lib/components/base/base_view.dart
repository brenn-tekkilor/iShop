import 'package:flutter/material.dart';
import 'package:ishop/app/services/locator.dart';
import 'package:ishop/components/base/base_model.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  BaseView({this.builder, this.onModelReady});

  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }
}