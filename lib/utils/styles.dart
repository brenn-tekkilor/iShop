import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppStyles {
  static final ButtonThemeData primaryButtonTheme = ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    highlightColor: AppColors.primaryLightColor,
    focusColor: AppColors.primaryDarkColor,
    buttonColor: AppColors.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2.0),
    ),
    height: 60,
    minWidth: 0.0,
    padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
    splashColor: AppColors.secondaryLightColor,
  );
  static final TextTheme primaryTextTheme = TextTheme(
    headline1: GoogleFonts.metrophobic(
        fontSize: 103, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.metrophobic(
        fontSize: 64, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3:
        GoogleFonts.metrophobic(fontSize: 51, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.metrophobic(
        fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5:
        GoogleFonts.metrophobic(fontSize: 26, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.metrophobic(
        fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.metrophobic(
        fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.metrophobic(
        fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.spartan(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.spartan(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.spartan(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.spartan(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.spartan(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
  static final TextTheme accentTextTheme = TextTheme(
    headline1: GoogleFonts.concertOne(
        fontSize: 104, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.concertOne(
        fontSize: 65, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3:
        GoogleFonts.concertOne(fontSize: 52, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.concertOne(
        fontSize: 37, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5:
        GoogleFonts.concertOne(fontSize: 26, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.concertOne(
        fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.concertOne(
        fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.concertOne(
        fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.neuton(
        fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.neuton(
        fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.neuton(
        fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.neuton(
        fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.neuton(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
  static final IconThemeData primaryIconTheme = IconThemeData(
    color: AppColors.secondaryDarkColor,
    opacity: 0.0,
    size: 60,
  );
  static final IconThemeData secondaryIconTheme = IconThemeData(
    color: AppColors.primaryDarkAccentColor,
    opacity: 0.8,
    size: 48,
  );
  static final SliderThemeData primarySliderTheme = SliderThemeData(
    activeTickMarkColor: AppColors.primaryColor.withOpacity(0.2),
    activeTrackColor: AppColors.secondaryDarkColor.withOpacity(0.2),
    inactiveTickMarkColor: AppColors.primaryColor.withOpacity(0.8),
    inactiveTrackColor: AppColors.secondaryLightColor.withOpacity(0.8),
    showValueIndicator: ShowValueIndicator.onlyForContinuous,
    thumbColor: AppColors.primaryColor,
    thumbShape: RoundSliderThumbShape(
      disabledThumbRadius: 20.0,
      enabledThumbRadius: 20.0,
    ),
    trackHeight: 20.0,
    trackShape: RoundedRectSliderTrackShape(),
    valueIndicatorColor: AppColors.primaryDarkAccentColor,
    valueIndicatorTextStyle: accentTextTheme.overline,
  );
  static final ToggleButtonsThemeData primaryToggleButtonsTheme =
      ToggleButtonsThemeData(
    color: AppColors.secondaryDarkColor,
    splashColor: AppColors.primaryLightAccentColor,
    highlightColor: AppColors.secondaryLightColor,
    textStyle: accentTextTheme.bodyText1.copyWith(
      color: AppColors.black1,
    ),
    focusColor: AppColors.secondaryLightColor,
    hoverColor: AppColors.secondaryLightColor,
    selectedColor: AppColors.secondaryColor,
  );
  static final ThemeData primaryTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryLightColor,
    primaryColorDark: AppColors.primaryDarkColor,
    primaryColorBrightness: Brightness.light,
    visualDensity: VisualDensity.comfortable,
    accentColor: AppColors.primaryLightAccentColor,
    accentColorBrightness: Brightness.light,
    backgroundColor: AppColors.white2,
    canvasColor: AppColors.white1,
    shadowColor: AppColors.lightShadowColor,
    scaffoldBackgroundColor: AppColors.white2,
    bottomAppBarColor: AppColors.primaryDarkColor,
    cardColor: AppColors.primaryLightColor,
    brightness: Brightness.light,
    buttonColor: AppColors.primaryColor,
    focusColor: AppColors.primaryDarkColor,
    highlightColor: AppColors.secondaryLightColor,
    textTheme: primaryTextTheme,
    appBarTheme: AppBarTheme(
      textTheme: primaryTextTheme,
      brightness: Brightness.light,
      actionsIconTheme: secondaryIconTheme,
      color: AppColors.secondaryColor,
      shadowColor: AppColors.darkShardowColor,
    ),
    buttonTheme: primaryButtonTheme,
    splashColor: AppColors.secondaryColor,
    hintColor: AppColors.primaryDarkAccentColor,
    primaryIconTheme: primaryIconTheme,
    accentIconTheme: secondaryIconTheme,
    primaryTextTheme: primaryTextTheme,
    tooltipTheme: TooltipThemeData(
      height: 20.0,
      textStyle: primaryTextTheme.caption.copyWith(
        color: AppColors.secondaryColor,
        height: 15,
      ),
      showDuration: Duration(milliseconds: 1200),
      waitDuration: Duration(milliseconds: 700),
    ),
    accentTextTheme: accentTextTheme,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      shadowColor: AppColors.lightShadowColor,
      color: AppColors.primaryLightColor,
      clipBehavior: Clip.antiAlias,
    ),
    iconTheme: primaryIconTheme,
    sliderTheme: primarySliderTheme,
    toggleableActiveColor: AppColors.secondaryLightColor,
    toggleButtonsTheme: primaryToggleButtonsTheme,
  );
}

DecorationImage backgroundImage = DecorationImage(
  image: ExactAssetImage('assets/images/login.jpg'),
  fit: BoxFit.cover,
);

DecorationImage tick = DecorationImage(
  image: ExactAssetImage('assets/images/tick.png'),
  fit: BoxFit.cover,
);
