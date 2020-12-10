import 'package:flutter/material.dart';

/// tappedStates
const Set<MaterialState> tappedStates = <MaterialState>{
  MaterialState.pressed,
  MaterialState.selected,
};

/// focusedStates
const Set<MaterialState> focusedStates = <MaterialState>{
  MaterialState.focused,
  MaterialState.hovered,
};

//#region typography
/// primaryTypography
final Typography primaryTypography = Typography.material2018(
  black: primaryBlackTextTheme,
  white: _primaryWhiteTextTheme,
);

/// secondaryTypography
final Typography secondaryTypography = Typography.material2018(
  black: _secondaryBlackTextTheme,
  white: _secondaryWhiteTextTheme,
);

/// headerStyle
const headerStyle = TextStyle(fontSize: 35, fontWeight: FontWeight.w900);

/// subHeaderStyle
const subHeaderStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

const AppBarTheme _primaryAppBarTheme = AppBarTheme(
  brightness: Brightness.dark,
  color: secondaryColor,
  iconTheme: _secondaryIconTheme,
  shadowColor: darkShadowColor,
  textTheme: primaryBlackTextTheme,
  actionsIconTheme: _secondaryIconTheme,
  centerTitle: false,
);

/// primaryBlackShadesTextTheme
const TextTheme primaryBlackShadesTextTheme = TextTheme(
  headline1: TextStyle(color: Colors.black54),
  headline2: TextStyle(color: Colors.black54),
  headline3: TextStyle(color: Colors.black54),
  headline4: TextStyle(color: Colors.black54),
  headline5: TextStyle(color: Colors.black87),
  headline6: TextStyle(color: Colors.black87),
  subtitle1: TextStyle(color: Colors.black87),
  subtitle2: TextStyle(color: Colors.black),
  bodyText1: TextStyle(color: Colors.black87),
  bodyText2: TextStyle(color: Colors.black87),
  button: TextStyle(color: Colors.black87),
  caption: TextStyle(color: Colors.black54),
  overline: TextStyle(color: Colors.black),
);

/// primaryWhiteShadesTextTheme
const TextTheme primaryWhiteShadesTextTheme = TextTheme(
  headline1: TextStyle(color: Colors.white70),
  headline2: TextStyle(color: Colors.white70),
  headline3: TextStyle(color: Colors.white70),
  headline4: TextStyle(color: Colors.white70),
  headline5: TextStyle(color: Colors.white),
  headline6: TextStyle(color: Colors.white),
  subtitle1: TextStyle(color: Colors.white),
  subtitle2: TextStyle(color: Colors.white),
  bodyText1: TextStyle(color: Colors.white),
  bodyText2: TextStyle(color: Colors.white),
  button: TextStyle(color: Colors.white),
  caption: TextStyle(color: Colors.white),
  overline: TextStyle(color: Colors.white),
);

/// primaryBlackTextTheme
const TextTheme primaryBlackTextTheme = TextTheme(
    headline1: TextStyle(
        color: Colors.black54,
        debugLabel: 'primaryTextTheme headline1',
        fontFamily: 'Metrophobic',
        fontSize: 103,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5),
    headline2: TextStyle(
        color: Colors.black54,
        debugLabel: 'primaryTextTheme headline2',
        fontFamily: 'Metrophobic',
        fontSize: 64,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5),
    headline3: TextStyle(
        color: Colors.black54,
        debugLabel: 'primaryTextTheme headline3',
        fontFamily: 'Metrophobic',
        fontSize: 51,
        fontWeight: FontWeight.w400),
    headline4: TextStyle(
        color: Colors.black54,
        debugLabel: 'primaryTextTheme headline4',
        fontFamily: 'Metrophobic',
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25),
    headline5: TextStyle(
        color: Colors.black87,
        debugLabel: 'primaryTextTheme headline5',
        fontFamily: 'Metrophobic',
        fontSize: 26,
        fontWeight: FontWeight.w400),
    headline6: TextStyle(
        color: Colors.black87,
        debugLabel: 'primaryTextTheme headline6',
        fontFamily: 'Metrophobic',
        fontSize: 21,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15),
    subtitle1: TextStyle(
        color: Colors.black87,
        debugLabel: 'primaryTextTheme subtitle1',
        fontFamily: 'Metrophobic',
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15),
    subtitle2: TextStyle(
        color: Colors.black,
        debugLabel: 'primaryTextTheme subtitle2',
        fontFamily: 'Metrophobic',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1),
    bodyText1: TextStyle(
        color: Colors.black87,
        debugLabel: 'primaryTextTheme bodyText1',
        fontFamily: 'Spartan',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5),
    bodyText2: TextStyle(
        color: Colors.black87,
        debugLabel: 'primaryTextTheme bodyText2',
        fontFamily: 'Spartan',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25),
    button: TextStyle(
        color: Colors.black87,
        debugLabel: 'primaryTextTheme button',
        fontFamily: 'Spartan',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25),
    caption: TextStyle(
        color: Colors.black54,
        debugLabel: 'primaryTextTheme caption',
        fontFamily: 'Spartan',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4),
    overline: TextStyle(
        color: Colors.black,
        debugLabel: 'primaryTextTheme overline',
        fontFamily: 'Spartan',
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5));

/// primaryTextTheme
const TextTheme primaryTextTheme = TextTheme(
  headline1: TextStyle(
      debugLabel: 'primaryTextTheme headline1',
      fontFamily: 'Metrophobic',
      fontSize: 103,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5),
  headline2: TextStyle(
      debugLabel: 'primaryTextTheme headline2',
      fontFamily: 'Metrophobic',
      fontSize: 64,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5),
  headline3: TextStyle(
      debugLabel: 'primaryTextTheme headline3',
      fontFamily: 'Metrophobic',
      fontSize: 51,
      fontWeight: FontWeight.w400),
  headline4: TextStyle(
      debugLabel: 'primaryTextTheme headline4',
      fontFamily: 'Metrophobic',
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25),
  headline5: TextStyle(
      debugLabel: 'primaryTextTheme headline5',
      fontFamily: 'Metrophobic',
      fontSize: 26,
      fontWeight: FontWeight.w400),
  headline6: TextStyle(
      debugLabel: 'primaryTextTheme headline6',
      fontFamily: 'Metrophobic',
      fontSize: 21,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15),
  subtitle1: TextStyle(
      debugLabel: 'primaryTextTheme subtitle1',
      fontFamily: 'Metrophobic',
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15),
  subtitle2: TextStyle(
      debugLabel: 'primaryTextTheme subtitle2',
      fontFamily: 'Metrophobic',
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1),
  bodyText1: TextStyle(
      debugLabel: 'primaryTextTheme bodyText1',
      fontFamily: 'Spartan',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5),
  bodyText2: TextStyle(
      debugLabel: 'primaryTextTheme bodyText2',
      fontFamily: 'Spartan',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25),
  button: TextStyle(
      debugLabel: 'primaryTextTheme button',
      fontFamily: 'Spartan',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25),
  caption: TextStyle(
      debugLabel: 'primaryTextTheme caption',
      fontFamily: 'Spartan',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4),
  overline: TextStyle(
      debugLabel: 'primaryTextTheme overline',
      fontFamily: 'Spartan',
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5),
);

/// primaryWhiteTextTheme
const TextTheme _primaryWhiteTextTheme = TextTheme(
  headline1: TextStyle(
      color: Colors.white70,
      debugLabel: 'primaryTextTheme headline1',
      fontFamily: 'Metrophobic',
      fontSize: 103,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5),
  headline2: TextStyle(
      color: Colors.white70,
      debugLabel: 'primaryTextTheme headline2',
      fontFamily: 'Metrophobic',
      fontSize: 64,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5),
  headline3: TextStyle(
      color: Colors.white70,
      debugLabel: 'primaryTextTheme headline3',
      fontFamily: 'Metrophobic',
      fontSize: 51,
      fontWeight: FontWeight.w400),
  headline4: TextStyle(
      color: Colors.white70,
      debugLabel: 'primaryTextTheme headline4',
      fontFamily: 'Metrophobic',
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25),
  headline5: TextStyle(
      color: Colors.white,
      debugLabel: 'primaryTextTheme headline5',
      fontFamily: 'Metrophobic',
      fontSize: 26,
      fontWeight: FontWeight.w400),
  headline6: TextStyle(
      color: Colors.white,
      debugLabel: 'primaryTextTheme headline6',
      fontFamily: 'Metrophobic',
      fontSize: 21,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15),
  subtitle1: TextStyle(
      color: Colors.white,
      debugLabel: 'primaryTextTheme subtitle1',
      fontFamily: 'Metrophobic',
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15),
  subtitle2: TextStyle(
      color: Colors.white,
      debugLabel: 'primaryTextTheme subtitle2',
      fontFamily: 'Metrophobic',
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1),
  bodyText1: TextStyle(
      color: Colors.white,
      debugLabel: 'primaryTextTheme bodyText1',
      fontFamily: 'Spartan',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5),
  bodyText2: TextStyle(
      color: Colors.white,
      debugLabel: 'primaryTextTheme bodyText2',
      fontFamily: 'Spartan',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25),
  button: TextStyle(
      color: Colors.white,
      debugLabel: 'primaryTextTheme button',
      fontFamily: 'Spartan',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25),
  caption: TextStyle(
      color: Colors.white,
      debugLabel: 'primaryTextTheme caption',
      fontFamily: 'Spartan',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4),
  overline: TextStyle(
      color: Colors.white,
      debugLabel: 'primaryTextTheme overline',
      fontFamily: 'Spartan',
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5),
);

/// secondaryBlackTextTheme
const TextTheme _secondaryBlackTextTheme = TextTheme(
  headline1: TextStyle(
      color: Colors.black54,
      debugLabel: 'secondaryTextTheme headline1',
      fontFamily: 'ConcertOne',
      fontSize: 104,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5),
  headline2: TextStyle(
      color: Colors.black54,
      debugLabel: 'secondaryTextTheme headline2',
      fontFamily: 'ConcertOne',
      fontSize: 65,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5),
  headline3: TextStyle(
      color: Colors.black54,
      debugLabel: 'secondaryTextTheme headline3',
      fontFamily: 'ConcertOne',
      fontSize: 52,
      fontWeight: FontWeight.w400),
  headline4: TextStyle(
      color: Colors.black54,
      debugLabel: 'secondaryTextTheme headline4',
      fontFamily: 'ConcertOne',
      fontSize: 37,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25),
  headline5: TextStyle(
      color: Colors.black87,
      debugLabel: 'secondaryTextTheme headline5',
      fontFamily: 'ConcertOne',
      fontSize: 26,
      fontWeight: FontWeight.w400),
  headline6: TextStyle(
      color: Colors.black87,
      debugLabel: 'secondaryTextTheme headline6',
      fontFamily: 'ConcertOne',
      // ignore: avoid_redundant_argument_values
      inherit: true,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15),
  subtitle1: TextStyle(
      color: Colors.black87,
      debugLabel: 'secondaryTextTheme subtitle1',
      fontFamily: 'ConcertOne',
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15),
  subtitle2: TextStyle(
      color: Colors.black,
      debugLabel: 'secondaryTextTheme subtitle2',
      fontFamily: 'ConcertOne',
      // ignore: avoid_redundant_argument_values
      inherit: true,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1),
  bodyText1: TextStyle(
      color: Colors.black87,
      debugLabel: 'secondaryTextTheme bodyText1',
      fontFamily: 'Neuton',
      fontSize: 20,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5),
  bodyText2: TextStyle(
      color: Colors.black87,
      debugLabel: 'secondaryTextTheme bodyText2',
      fontFamily: 'Neuton',
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25),
  button: TextStyle(
      color: Colors.black87,
      debugLabel: 'secondaryTextTheme button',
      fontFamily: 'Neuton',
      fontSize: 17,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25),
  caption: TextStyle(
      color: Colors.black54,
      debugLabel: 'secondaryTextTheme caption',
      fontFamily: 'Neuton',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4),
  overline: TextStyle(
      color: Colors.black,
      debugLabel: 'secondaryTextTheme overline',
      fontFamily: 'Neuton',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5),
);

/// secondaryTextTheme
const TextTheme secondaryTextTheme = TextTheme(
  headline1: TextStyle(
      debugLabel: 'secondaryTextTheme headline1',
      fontFamily: 'ConcertOne',
      fontSize: 104,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5),
  headline2: TextStyle(
      debugLabel: 'secondaryTextTheme headline2',
      fontFamily: 'ConcertOne',
      fontSize: 65,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5),
  headline3: TextStyle(
      debugLabel: 'secondaryTextTheme headline3',
      fontFamily: 'ConcertOne',
      fontSize: 52,
      fontWeight: FontWeight.w400),
  headline4: TextStyle(
      debugLabel: 'secondaryTextTheme headline4',
      fontFamily: 'ConcertOne',
      fontSize: 37,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25),
  headline5: TextStyle(
      debugLabel: 'secondaryTextTheme headline5',
      fontFamily: 'ConcertOne',
      fontSize: 26,
      fontWeight: FontWeight.w400),
  headline6: TextStyle(
      debugLabel: 'secondaryTextTheme headline6',
      fontFamily: 'ConcertOne',
      // ignore: avoid_redundant_argument_values
      inherit: true,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15),
  subtitle1: TextStyle(
      debugLabel: 'secondaryTextTheme subtitle1',
      fontFamily: 'ConcertOne',
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15),
  subtitle2: TextStyle(
      debugLabel: 'secondaryTextTheme subtitle2',
      fontFamily: 'ConcertOne',
      // ignore: avoid_redundant_argument_values
      inherit: true,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1),
  bodyText1: TextStyle(
      debugLabel: 'secondaryTextTheme bodyText1',
      fontFamily: 'Neuton',
      fontSize: 20,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5),
  bodyText2: TextStyle(
      debugLabel: 'secondaryTextTheme bodyText2',
      fontFamily: 'Neuton',
      fontSize: 17,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25),
  button: TextStyle(
      debugLabel: 'secondaryTextTheme button',
      fontFamily: 'Neuton',
      fontSize: 17,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25),
  caption: TextStyle(
      debugLabel: 'secondaryTextTheme caption',
      fontFamily: 'Neuton',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4),
  overline: TextStyle(
      debugLabel: 'secondaryTextTheme overline',
      fontFamily: 'Neuton',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5),
);

/// secondaryWhiteTextTheme
const TextTheme _secondaryWhiteTextTheme = TextTheme(
    headline1: TextStyle(
        color: Colors.white70,
        debugLabel: 'secondaryTextTheme headline1',
        fontFamily: 'ConcertOne',
        fontSize: 104,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5),
    headline2: TextStyle(
        color: Colors.white70,
        debugLabel: 'secondaryTextTheme headline2',
        fontFamily: 'ConcertOne',
        fontSize: 65,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5),
    headline3: TextStyle(
        color: Colors.white70,
        debugLabel: 'secondaryTextTheme headline3',
        fontFamily: 'ConcertOne',
        fontSize: 52,
        fontWeight: FontWeight.w400),
    headline4: TextStyle(
        color: Colors.white70,
        debugLabel: 'secondaryTextTheme headline4',
        fontFamily: 'ConcertOne',
        fontSize: 37,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25),
    headline5: TextStyle(
        color: Colors.white,
        debugLabel: 'secondaryTextTheme headline5',
        fontFamily: 'ConcertOne',
        fontSize: 26,
        fontWeight: FontWeight.w400),
    headline6: TextStyle(
        color: Colors.white,
        debugLabel: 'secondaryTextTheme headline6',
        fontFamily: 'ConcertOne',
        // ignore: avoid_redundant_argument_values
        inherit: true,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15),
    subtitle1: TextStyle(
        color: Colors.white,
        debugLabel: 'secondaryTextTheme subtitle1',
        fontFamily: 'ConcertOne',
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15),
    subtitle2: TextStyle(
        color: Colors.white,
        debugLabel: 'secondaryTextTheme subtitle2',
        fontFamily: 'ConcertOne',
        // ignore: avoid_redundant_argument_values
        inherit: true,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1),
    bodyText1: TextStyle(
        color: Colors.white,
        debugLabel: 'secondaryTextTheme bodyText1',
        fontFamily: 'Neuton',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5),
    bodyText2: TextStyle(
        color: Colors.white,
        debugLabel: 'secondaryTextTheme bodyText2',
        fontFamily: 'Neuton',
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25),
    button: TextStyle(
        color: Colors.white,
        debugLabel: 'secondaryTextTheme button',
        fontFamily: 'Neuton',
        fontSize: 17,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25),
    caption: TextStyle(
        color: Colors.white,
        debugLabel: 'secondaryTextTheme caption',
        fontFamily: 'Neuton',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4),
    overline: TextStyle(
        color: Colors.white,
        debugLabel: 'secondaryTextTheme overline',
        fontFamily: 'Neuton',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5));
//#endregion
//#region themes
/// primaryTheme
final ThemeData primaryTheme = ThemeData(
  primaryColor: primaryColor,
  primaryColorLight: primaryColorLighter,
  primaryColorDark: primaryColorDarker,
  primaryColorBrightness: Brightness.light,
  colorScheme: primaryLightColorScheme,
  dialogBackgroundColor: brightWhite,
  dialogTheme: _primaryDialogTheme,
  fontFamily: 'Metrophobic',
  primarySwatch: primaryColorSwatch,
  typography: primaryTypography,
  visualDensity: VisualDensity.comfortable,
  accentColor: primaryAccentColor,
  accentColorBrightness: Brightness.light,
  backgroundColor: brightWhite,
  canvasColor: white,
  shadowColor: lightShadowColor,
  scaffoldBackgroundColor: brightWhite,
  bottomAppBarColor: primaryColorDarker,
  brightness: Brightness.light,
  focusColor: primaryColorDarker,
  highlightColor: secondaryColorLighter,
  textTheme: primaryTextTheme,
  appBarTheme: _primaryAppBarTheme,
  splashColor: secondaryColor,
  hintColor: secondaryAccentColor,
  primaryIconTheme: _primaryIconTheme,
  accentIconTheme: _secondaryIconTheme,
  primaryTextTheme: primaryTextTheme,
  tooltipTheme: _primaryTooltipTheme,
  accentTextTheme: secondaryTextTheme,
  cardTheme: _primaryCardTheme,
  iconTheme: _primaryIconTheme,
  toggleableActiveColor: secondaryColorLighter,
  toggleButtonsTheme: _primaryToggleTheme,
);
const CardTheme _primaryCardTheme = CardTheme(
  clipBehavior: Clip.antiAlias,
  margin: EdgeInsets.all(10),
);

const DialogTheme _primaryDialogTheme = DialogTheme(
  backgroundColor: brightWhite,
  elevation: 100,
);

/// primaryButtonTheme
const ButtonThemeData primaryButtonTheme = ButtonThemeData(
  textTheme: ButtonTextTheme.primary,
  highlightColor: primaryColorLighter,
  focusColor: primaryColorDarker,
  buttonColor: primaryColor,
  height: 60,
  minWidth: 0,
  padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
  splashColor: secondaryColorLighter,
);
const IconThemeData _primaryIconTheme = IconThemeData(
  color: secondaryColorDarker,
  size: 60,
);
const ToggleButtonsThemeData _primaryToggleTheme = ToggleButtonsThemeData(
  color: secondaryColorDarker,
  splashColor: primaryAccentColor,
  highlightColor: secondaryColorLighter,
  focusColor: secondaryColorLighter,
  hoverColor: secondaryColorLighter,
  selectedColor: secondaryColor,
);
const TooltipThemeData _primaryTooltipTheme = TooltipThemeData(
  height: 20,
  textStyle: TextStyle(
      color: secondaryColor,
      debugLabel: 'primaryTextTheme caption',
      fontFamily: 'Spartan',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4),
  showDuration: Duration(milliseconds: 1200),
  waitDuration: Duration(milliseconds: 700),
);
const IconThemeData _secondaryIconTheme = IconThemeData(
  color: secondaryAccentColor,
  size: 48,
);

/// primaryButtonStyle
ButtonStyle primaryButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.resolveWith(outlinedBorderState),
  backgroundColor:
      MaterialStateProperty.resolveWith(buttonBackgroundColorState),
  foregroundColor:
      MaterialStateProperty.resolveWith(buttonForegroundColorState),
  overlayColor: MaterialStateProperty.resolveWith(buttonOverlayColorState),
  shadowColor: MaterialStateProperty.resolveWith(buttonShadowColorState),
  padding: MaterialStateProperty.resolveWith(buttonPaddingState),
);

/// primaryOutlinedButtonTheme
OutlinedButtonThemeData primaryOutlinedButtonTheme = OutlinedButtonThemeData(
  style: primaryButtonStyle,
);
//#endregion
//#region methods
/// buttonBackgroundColorState
Color? buttonBackgroundColorState(Set<MaterialState> states) =>
    states.any(tappedStates.contains)
        ? Colors.blueAccent.withOpacity(0.5)
        : states.any(focusedStates.contains)
            ? primaryColor.withOpacity(0.5)
            : Colors.white;

/// buttonForegroundColorState
Color? buttonForegroundColorState(Set<MaterialState> states) =>
    states.any(tappedStates.contains)
        ? secondaryColorDarker
        : states.any(focusedStates.contains)
            ? Colors.white
            : Colors.black87;

/// buttonOverlayColorState
Color? buttonOverlayColorState(Set<MaterialState> states) =>
    states.any(tappedStates.contains)
        ? secondaryAccentColor.withOpacity(0.5)
        : states.any(focusedStates.contains)
            ? primaryColorLighter
            : Colors.white;
//// buttonShadowColorState
Color? buttonShadowColorState(Set<MaterialState> states) =>
    states.any(tappedStates.contains)
        ? Colors.transparent
        : states.any(focusedStates.contains)
            ? Colors.black.withOpacity(0.5)
            : Colors.grey.withOpacity(0.5);

/// buttonPaddingState
EdgeInsetsGeometry? buttonPaddingState(Set<MaterialState> states) =>
    states.any(focusedStates.contains) ? const EdgeInsets.all(15) : null;

/// outlinedBorderState
OutlinedBorder? outlinedBorderState(Set<MaterialState> states) =>
    states.any(tappedStates.contains)
        ? const RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: Colors.blueAccent,
            ),
          )
        : states.any(focusedStates.contains)
            ? const RoundedRectangleBorder(
                side: BorderSide(
                width: 2,
                color: Colors.lime,
              ))
            : const RoundedRectangleBorder(
                side: BorderSide(),
              );
//#endregion
/// primaryLightColorScheme
const ColorScheme primaryLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  background: brightWhite,
  primary: primaryColor,
  secondary: secondaryColor,
  primaryVariant: primaryColorLighter,
  secondaryVariant: secondaryColorLighter,
  error: red,
  surface: brightWhite,
  onBackground: black,
  onSecondary: black,
  onError: white,
  onPrimary: black,
  onSurface: black,
);

/// backgroundColor
const Color backgroundColor = Color.fromARGB(255, 255, 241, 159);

/// commentColor
const Color commentColor = Color.fromARGB(255, 255, 246, 196);

/// primaryColorLighter
const Color primaryColorLighter = Color(0xff63ff7b);

/// primaryColor
const Color primaryColor = Color(0xff00d64a);

/// primaryColorDarker
const Color primaryColorDarker = Color(0xff00a313);

/// secondaryColorLighter
const Color secondaryColorLighter = Color(0xffff55bc);

/// secondaryColor
const Color secondaryColor = Color(0xffd7008c);

/// secondaryColorDarker
const Color secondaryColorDarker = Color(0xffa0005f);

/// primaryAccentColor
const Color primaryAccentColor = Color(0xff008cd7);

/// secondaryAccentColor
const Color secondaryAccentColor = Color(0xff4b00d7);

/// white
const Color white = Color(0xffffffff);

/// brightWhite
const Color brightWhite = Color(0xfffafafa);

/// secondaryWhiteTextColor
const Color secondaryWhiteTextColor = Color(0xB3FFFFFF);

/// lightShadowColor
const Color lightShadowColor = Color(0x80718792);

/// black
const Color black = Color(0xff000000);

/// primaryBlackTextColor
const Color primaryBlackTextColor = Color(0xDD000000);

/// secondaryBlackTextColor
const Color secondaryBlackTextColor = Color(0x8A000000);

/// gunMetalBlack
const Color gunMetalBlack = Color(0xff212121);

/// darkShadowColor
const Color darkShadowColor = Color(0x801c313a);

/// red
const Color red = Color(0xffd50000);

/// primaryColorSwatch
const primaryColorSwatch = MaterialColor(0xff00d64a, <int, Color>{
  50: Color(0xff80eba5),
  100: Color(0xff66e692),
  200: Color(0xff4de280),
  300: Color(0xff33de6e),
  400: Color(0xff1ada5c),
  500: Color(0xff00d64a),
  600: Color(0xff00c143),
  700: Color(0xff00ab3b),
  800: Color(0xff009634),
  900: Color(0xff00802c),
});

/// secondaryColorSwatch
const secondaryColorSwatch = MaterialColor(0xffd7008c, <int, Color>{
  50: Color(0xffe766ba),
  100: Color(0xffe34daf),
  200: Color(0xffe34daf),
  300: Color(0xffdf33a3),
  400: Color(0xffdb1a98),
  500: Color(0xffd7008c),
  600: Color(0xffc2007e),
  700: Color(0xffac0070),
  800: Color(0xff970062),
  900: Color(0xff810054),
});

/// primaryAccentColorSwatch
const primaryAccentColorSwatch = MaterialColor(0xff008cd7e, <int, Color>{
  50: Color(0xff80c6eb),
  100: Color(0xff66bae7),
  200: Color(0xff4dafe3),
  300: Color(0xff33a3df),
  400: Color(0xff1a98db),
  500: Color(0xff008cd7),
  600: Color(0xff007ec2),
  700: Color(0xff0070ac),
  800: Color(0xff006297),
  900: Color(0xff005481),
});

/// secondaryAccentColorSwatch
const secondaryAccentColorSwatch = MaterialColor(0xff4b00d7, <int, Color>{
  50: Color(0xffa580eb),
  100: Color(0xff9366e7),
  200: Color(0xff814de3),
  300: Color(0xff6f33df),
  400: Color(0xff5d1adb),
  500: Color(0xff4b00d7),
  600: Color(0xff4400c2),
  700: Color(0xff3c00ac),
  800: Color(0xff350097),
  900: Color(0xff2d0081),
});
//#endregion
