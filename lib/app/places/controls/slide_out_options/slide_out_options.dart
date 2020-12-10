import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/places/controls/slide_out_options/slide_out_button.dart';
import 'package:ishop/app/places/controls/slide_out_options/slide_out_option.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/enums/place_banner.dart';
import 'package:provider/provider.dart';

/// SlideOutOptions
class SlideOutOptions extends StatefulWidget {
  /// SlideOutOptions constructor
  const SlideOutOptions({
    Key? key,
  }) : super(key: key);

  @override
  _SlideOutOptionsState createState() => _SlideOutOptionsState();
}

/// SlideOutOptionsState
class _SlideOutOptionsState extends State<SlideOutOptions>
    with TickerProviderStateMixin {
  _SlideOutOptionsState()
      : _marketplace = Image.asset(
          'assets/pins/marketplace_pin.png',
          fit: BoxFit.scaleDown,
        ),
        _foodAndDrug = Image.asset(
          'assets/pins/food_and_drug_pin.png',
          fit: BoxFit.scaleDown,
        ),
        _filter = Image.asset(
          'assets/pins/filter_pin.png',
          fit: BoxFit.scaleDown,
        );
  final Image _marketplace;
  final Image _foodAndDrug;
  final Image _filter;
  late final AnimationController _controller;
  late Image _current;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _current = _filter;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _open() {
    _controller.forward(from: _controller.value);
  }

  void _close() {
    _controller.reverse(from: _controller.value);
  }

  void _toggle() {
    if (!_controller.isAnimating) {
      if (_controller.status == AnimationStatus.completed) {
        _close();
      } else {
        _open();
      }
    }
  }

  PlaceBanner get _banner =>
      Provider.of<PlacesProvider>(context, listen: false).selectedBanner;
  set _banner(PlaceBanner value) {
    if (_banner != value) {
      Provider.of<PlacesProvider>(context, listen: false).selectedBanner =
          value;
    }
  }

  void _optionOnTap(PlaceBanner value) {
    final b = _banner == PlaceBanner.all ? value : PlaceBanner.all;
    _banner = b;
    setState(() => _current = b == PlaceBanner.all
        ? _filter
        : b == PlaceBanner.marketplace
            ? _marketplace
            : _foodAndDrug);
    _toggle();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 20,
              child: SlideOutOption(
                animation: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(
                      0.2,
                      0.5,
                      curve: Curves.easeInOut,
                    ))),
                controller: _controller,
                child: TextButton(
                  clipBehavior: Clip.antiAlias,
                  onPressed: _current == _marketplace
                      ? null
                      : () => _optionOnTap(PlaceBanner.marketplace),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: _current == _marketplace
                        ? Image(
                            image: _marketplace.image,
                            color: Colors.white70,
                            colorBlendMode: BlendMode.overlay,
                          )
                        : _marketplace,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 80,
              child: SlideOutOption(
                animation: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(
                      0.6,
                      1,
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
                controller: _controller,
                child: TextButton(
                  onPressed: _current == _foodAndDrug
                      ? null
                      : () => _optionOnTap(PlaceBanner.foodAndDrug),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: _current == _foodAndDrug
                        ? Image(
                            image: _foodAndDrug.image,
                            color: Colors.white70,
                            colorBlendMode: BlendMode.overlay,
                          )
                        : _foodAndDrug,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: SlideOutButton(
                controller: _controller,
                animation: Tween<double>(
                  begin: 0,
                  end: -143,
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                )),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _toggle,
                  child: SizedBox(
                    width: 65,
                    height: 65,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _current,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
