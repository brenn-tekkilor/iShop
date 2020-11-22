import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget implements PreferredSizeWidget {
  const BasicButton({Key? key, String text = '', required VoidCallback onTap})
      : _text = text,
        _onTap = onTap,
        super(key: key);

  final String _text;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(247, 64, 106, 1.0),
            borderRadius: BorderRadius.all(const Radius.circular(30.0)),
          ),
          child: Text(
            _text,
            style: Theme.of(context)?.typography.white.headline6,
          ),
        ),
        onTap: _onTap,
      );

  @override
  Size get preferredSize => Size(320, 60);
}
