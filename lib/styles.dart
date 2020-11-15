import 'package:flutter/material.dart';

abstract class AppColors {
  static final Color primaryColorLighter = Color(0xff63ff7b);
  static final Color primaryColor = Color(0xff00d64a);
  static final Color primaryColorDarker = Color(0xff00a313);
  static final Color secondaryColorLighter = Color(0xffff55bc);
  static final Color secondaryColor = Color(0xffd7008c);
  static final Color secondaryColorDarker = Color(0xffa0005f);
  static final Color primaryAccentColor = Color(0xff008cd7);
  static final Color secondaryAccentColor = Color(0xff4b00d7);
  static final Color white = Color(0xffffffff);
  static final Color brightWhite = Color(0xfffafafa);
  static final Color secondaryWhiteTextColor = Color(0xB3FFFFFF);
  static final Color lightShadowColor = Color(0x80718792);
  static final Color black = Color(0xff000000);
  static final Color primaryBlackTextColor = Color(0xDD000000);
  static final Color secondaryBlackTextColor = Color(0x8A000000);
  static final Color gunMetalBlack = Color(0xff212121);
  static final Color darkShadowColor = Color(0x801c313a);
  static final Color red = Color(0xffd50000);
}

class AppStyles {
  //#region ctor
  AppStyles._create();
  //#endregion
  //#region static properties
  //#region colors/swatches/icons
  //#region swatches
  static const primaryColorSwatch = MaterialColor(0xff00d64a, <int, Color>{
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
  static const secondaryColorSwatch = MaterialColor(0xffd7008c, <int, Color>{
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
  static const primaryAccentColorSwatch =
      MaterialColor(0xff008cd7e, <int, Color>{
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
  static const secondaryAccentColorSwatch =
      MaterialColor(0xff4b00d7, <int, Color>{
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
  //#endregion
  /*
  //#region Themes/Schemes/ThemeData
  static ExpandableThemeData get expandableTheme => ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        alignment: Alignment.center,
        bodyAlignment: ExpandablePanelBodyAlignment.center,
        expandIcon: Icon(Icons.arrow_drop_down_circle_outlined).icon,
        collapseIcon: Icon(Icons.arrow_circle_up_outlined).icon,
        hasIcon: true,
        iconColor: secondaryColorSwatch.shade500,
        iconSize: 10.0,
        iconPlacement: ExpandablePanelIconPlacement.right,
        iconRotationAngle: pi,
        iconPadding: EdgeInsets.all(3.0),
      );

   */
  static ButtonStyle get bottomSheetButtonStyle => ButtonStyle(
        elevation: MaterialStateProperty.all<double>(50.0),
        backgroundColor:
            MaterialStateProperty.all<Color>(AppColors.primaryColor),
        textStyle: MaterialStateProperty.all(primaryBlackTextTheme.overline),
        shadowColor: MaterialStateProperty.all(AppColors.darkShadowColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        animationDuration: Duration(milliseconds: 500),
      );
  static AppBarTheme get primaryAppBarTheme => AppBarTheme(
        brightness: Brightness.dark,
        color: AppColors.secondaryColor,
        iconTheme: secondaryIconTheme,
        shadowColor: AppColors.darkShadowColor,
        textTheme: primaryBlackTextTheme,
        actionsIconTheme: secondaryIconTheme,
        centerTitle: false,
      );
  static TextTheme get primaryBlackShadesTextTheme => TextTheme(
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
  static TextTheme get primaryBlackTextTheme =>
      primaryTextTheme.merge(primaryBlackShadesTextTheme);
  static ButtonThemeData get primaryButtonTheme => ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        highlightColor: AppColors.primaryColorLighter,
        focusColor: AppColors.primaryColorDarker,
        buttonColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        height: 60,
        minWidth: 0.0,
        padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
        splashColor: AppColors.secondaryColorLighter,
      );
  static CardTheme get primaryCardTheme => CardTheme(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        shadowColor: AppColors.lightShadowColor,
        color: AppColors.primaryColorLighter,
        clipBehavior: Clip.antiAlias,
      );
  static DialogTheme get primaryDialogTheme => DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        backgroundColor: AppColors.brightWhite.withOpacity(0.8),
        contentTextStyle: primaryTextTheme.headline6,
        titleTextStyle: primaryTextTheme.headline4,
        elevation: 100.0,
      );
  static IconThemeData get primaryIconTheme => IconThemeData(
        color: AppColors.secondaryColorDarker,
        opacity: 0.0,
        size: 60,
      );
  static ColorScheme get primaryLightColorScheme => ColorScheme(
        brightness: Brightness.light,
        background: AppColors.brightWhite,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        primaryVariant: AppColors.primaryColorLighter,
        secondaryVariant: AppColors.secondaryColorLighter,
        error: AppColors.red,
        surface: AppColors.brightWhite,
        onBackground: AppColors.black,
        onSecondary: AppColors.black,
        onError: AppColors.white,
        onPrimary: AppColors.black,
        onSurface: AppColors.black,
      );
  static SliderThemeData get primarySliderTheme => SliderThemeData(
        overlayColor: secondaryColorSwatch.shade500,
        activeTickMarkColor: primaryAccentColorSwatch.shade500.withOpacity(0.8),
        activeTrackColor: AppColors.primaryAccentColor.withOpacity(0.8),
        inactiveTickMarkColor: AppColors.primaryColor.withOpacity(0.8),
        inactiveTrackColor: AppColors.secondaryColorLighter.withOpacity(0.6),
        showValueIndicator: ShowValueIndicator.always,
        thumbColor: AppColors.secondaryColor.withOpacity(0.8),
        thumbShape: RoundSliderThumbShape(
          disabledThumbRadius: 20.0,
          enabledThumbRadius: 20.0,
        ),
        trackHeight: 20.0,
        trackShape: RoundedRectSliderTrackShape(),
        valueIndicatorColor: AppColors.secondaryAccentColor,
        valueIndicatorTextStyle: secondaryTextTheme.overline,
      );
  static TextTheme get primaryTextTheme => TextTheme(
        headline1: TextStyle(
            debugLabel: 'primaryTextTheme headline1',
            fontFamily: 'Metrophobic',
            inherit: true,
            fontSize: 103,
            fontWeight: FontWeight.w300,
            letterSpacing: -1.5),
        headline2: TextStyle(
            debugLabel: 'primaryTextTheme headline2',
            fontFamily: 'Metrophobic',
            inherit: true,
            fontSize: 64,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5),
        headline3: TextStyle(
            debugLabel: 'primaryTextTheme headline3',
            fontFamily: 'Metrophobic',
            inherit: true,
            fontSize: 51,
            fontWeight: FontWeight.w400),
        headline4: TextStyle(
            debugLabel: 'primaryTextTheme headline4',
            fontFamily: 'Metrophobic',
            inherit: true,
            fontSize: 36,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25),
        headline5: TextStyle(
            debugLabel: 'primaryTextTheme headline5',
            fontFamily: 'Metrophobic',
            inherit: true,
            fontSize: 26,
            fontWeight: FontWeight.w400),
        headline6: TextStyle(
            debugLabel: 'primaryTextTheme headline6',
            fontFamily: 'Metrophobic',
            inherit: true,
            fontSize: 21,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15),
        subtitle1: TextStyle(
            debugLabel: 'primaryTextTheme subtitle1',
            fontFamily: 'Metrophobic',
            inherit: true,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15),
        subtitle2: TextStyle(
            debugLabel: 'primaryTextTheme subtitle2',
            fontFamily: 'Metrophobic',
            inherit: true,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1),
        bodyText1: TextStyle(
            debugLabel: 'primaryTextTheme bodyText1',
            fontFamily: 'Spartan',
            inherit: true,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5),
        bodyText2: TextStyle(
            debugLabel: 'primaryTextTheme bodyText2',
            fontFamily: 'Spartan',
            inherit: true,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25),
        button: TextStyle(
            debugLabel: 'primaryTextTheme button',
            fontFamily: 'Spartan',
            inherit: true,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25),
        caption: TextStyle(
            debugLabel: 'primaryTextTheme caption',
            fontFamily: 'Spartan',
            inherit: true,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4),
        overline: TextStyle(
            debugLabel: 'primaryTextTheme overline',
            fontFamily: 'Spartan',
            inherit: true,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5),
      );
  static ToggleButtonsThemeData get primaryToggleButtonsTheme =>
      ToggleButtonsThemeData(
        color: AppColors.secondaryColorDarker,
        splashColor: AppColors.primaryAccentColor,
        highlightColor: AppColors.secondaryColorLighter,
        textStyle: secondaryBlackTextTheme.bodyText1,
        focusColor: AppColors.secondaryColorLighter,
        hoverColor: AppColors.secondaryColorLighter,
        selectedColor: AppColors.secondaryColor,
      );
  static TooltipThemeData get primaryTooltipTheme => TooltipThemeData(
        height: 20.0,
        textStyle: primaryTextTheme.caption?.copyWith(
          color: AppColors.secondaryColor,
          height: 15,
        ),
        showDuration: Duration(milliseconds: 1200),
        waitDuration: Duration(milliseconds: 700),
      );
  static Typography get primaryTypography => Typography.material2018(
        black: primaryBlackTextTheme,
        white: primaryWhiteTextTheme,
      );
  static TextTheme get primaryWhiteShadesTextTheme => TextTheme(
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
        caption: TextStyle(color: Colors.white70),
        overline: TextStyle(color: Colors.white),
      );
  static TextTheme get primaryWhiteTextTheme =>
      primaryTextTheme.merge(primaryWhiteShadesTextTheme);
  static TextTheme get secondaryBlackTextTheme =>
      secondaryTextTheme.merge(primaryBlackShadesTextTheme);
  static IconThemeData get secondaryIconTheme => IconThemeData(
        color: AppColors.secondaryAccentColor,
        opacity: 0.8,
        size: 48,
      );
  static TextTheme get secondaryTextTheme => TextTheme(
        headline1: TextStyle(
            debugLabel: 'secondaryTextTheme headline1',
            fontFamily: 'ConcertOne',
            inherit: true,
            fontSize: 104,
            fontWeight: FontWeight.w300,
            letterSpacing: -1.5),
        headline2: TextStyle(
            debugLabel: 'secondaryTextTheme headline2',
            fontFamily: 'ConcertOne',
            inherit: true,
            fontSize: 65,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5),
        headline3: TextStyle(
            debugLabel: 'secondaryTextTheme headline3',
            fontFamily: 'ConcertOne',
            inherit: true,
            fontSize: 52,
            fontWeight: FontWeight.w400),
        headline4: TextStyle(
            debugLabel: 'secondaryTextTheme headline4',
            fontFamily: 'ConcertOne',
            inherit: true,
            fontSize: 37,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25),
        headline5: TextStyle(
            debugLabel: 'secondaryTextTheme headline5',
            fontFamily: 'ConcertOne',
            inherit: true,
            fontSize: 26,
            fontWeight: FontWeight.w400),
        headline6: TextStyle(
            debugLabel: 'secondaryTextTheme headline6',
            fontFamily: 'ConcertOne',
            inherit: true,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15),
        subtitle1: TextStyle(
            debugLabel: 'secondaryTextTheme subtitle1',
            fontFamily: 'ConcertOne',
            inherit: true,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15),
        subtitle2: TextStyle(
            debugLabel: 'secondaryTextTheme subtitle2',
            fontFamily: 'ConcertOne',
            inherit: true,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1),
        bodyText1: TextStyle(
            debugLabel: 'secondaryTextTheme bodyText1',
            fontFamily: 'Neuton',
            inherit: true,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5),
        bodyText2: TextStyle(
            debugLabel: 'secondaryTextTheme bodyText2',
            fontFamily: 'Neuton',
            inherit: true,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25),
        button: TextStyle(
            debugLabel: 'secondaryTextTheme button',
            fontFamily: 'Neuton',
            inherit: true,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25),
        caption: TextStyle(
            debugLabel: 'secondaryTextTheme caption',
            fontFamily: 'Neuton',
            inherit: true,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4),
        overline: TextStyle(
            debugLabel: 'secondaryTextTheme overline',
            fontFamily: 'Neuton',
            inherit: true,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5),
      );
  static Typography get secondaryTypography => Typography.material2018(
        black: secondaryBlackTextTheme,
        white: secondaryWhiteTextTheme,
      );
  static TextTheme get secondaryWhiteTextTheme =>
      secondaryTextTheme.merge(primaryWhiteShadesTextTheme);

  static const headerStyle =
      TextStyle(fontSize: 35, fontWeight: FontWeight.w900);
  static const subHeaderStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);

  static const Color backgroundColor = Color.fromARGB(255, 255, 241, 159);
  static const Color commentColor = Color.fromARGB(255, 255, 246, 196);

  //#endregion
  //#region primary theme
  static ThemeData get primaryTheme => ThemeData(
        primaryColor: AppColors.primaryColor,
        primaryColorLight: AppColors.primaryColorLighter,
        primaryColorDark: AppColors.primaryColorDarker,
        primaryColorBrightness: Brightness.light,
        colorScheme: primaryLightColorScheme,
        dialogBackgroundColor: AppColors.brightWhite.withOpacity(0.8),
        dialogTheme: primaryDialogTheme,
        fontFamily: 'Metrophobic',
        primarySwatch: primaryColorSwatch,
        typography: primaryTypography,
        visualDensity: VisualDensity.comfortable,
        accentColor: AppColors.primaryAccentColor,
        accentColorBrightness: Brightness.light,
        backgroundColor: AppColors.brightWhite,
        canvasColor: AppColors.white,
        shadowColor: AppColors.lightShadowColor,
        scaffoldBackgroundColor: AppColors.brightWhite,
        bottomAppBarColor: AppColors.primaryColorDarker,
        cardColor: AppColors.primaryColorLighter,
        brightness: Brightness.light,
        buttonColor: AppColors.primaryColor,
        focusColor: AppColors.primaryColorDarker,
        highlightColor: AppColors.secondaryColorLighter,
        textTheme: primaryTextTheme,
        appBarTheme: primaryAppBarTheme,
        buttonTheme: primaryButtonTheme,
        splashColor: AppColors.secondaryColor,
        hintColor: AppColors.secondaryAccentColor,
        primaryIconTheme: primaryIconTheme,
        accentIconTheme: secondaryIconTheme,
        primaryTextTheme: primaryTextTheme,
        tooltipTheme: primaryTooltipTheme,
        accentTextTheme: secondaryTextTheme,
        cardTheme: primaryCardTheme,
        iconTheme: primaryIconTheme,
        sliderTheme: primarySliderTheme,
        toggleableActiveColor: AppColors.secondaryColorLighter,
        toggleButtonsTheme: primaryToggleButtonsTheme,
      );
  //#endregion
  //#endregion
  //#region static helper methods
  T resolveMaterialStateProperty<T>(Set<MaterialState> states,
          {required Set<MaterialState> targetStates,
          required T targetValue,
          required T defaultValue}) =>
      (states.any(targetStates.contains)) ? targetValue : defaultValue;
  //#endregion
}
