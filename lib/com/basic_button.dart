import 'package:flutter/material.dart';

/// a basic button
class BasicButton extends StatelessWidget implements PreferredSizeWidget {
  /// basic button default const constructor
  const BasicButton({Key? key, String text = '', required VoidCallback onTap})
      : _text = text,
        _onTap = onTap,
        super(key: key);

  final String _text;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: _onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(247, 64, 106, 1),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Text(
            _text,
            style: Theme.of(context).typography.white.headline6,
          ),
        ),
      );

  @override
  Size get preferredSize => const Size(320, 60);
}
