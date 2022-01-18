import 'package:flutter/material.dart';

// https://developer.apple.com/design/human-interface-guidelines/macos/windows-and-views/window-anatomy/

// Main
//const mainBackgroundImage = AssetImage('images/meiying.jpg');
const mainBackgroundImage = AssetImage('images/monterey.jpg');

// Desktop
const desktopIconSize = 42.0;
const desktopItemSpacing = 20.0;

// Dock
const dockHeight = 28.0;
const dockBackgroundColor = Color.fromRGBO(30, 30, 30, 0.7);
const dockItemActiveBackgroundColor = Color.fromRGBO(108, 65, 165, 0.7);
const dockItemInactiveBackgroundColor = Colors.transparent;
const dockItemActiveTextColor = Colors.white;
const dockItemMinimizedTextColor = Color.fromRGBO(120, 120, 120, 1);

// Window
const windowTransitionMillis = Duration(milliseconds: 40);

const windowMinWidth = 84.0;
const windowMinHeight = 84.0;
const windowOuterPadding = 4.0;

const windowBodyColor = Color.fromRGBO(35, 31, 41, 1);
const windowBodySeparatorColor = Color.fromRGBO(0, 0, 0, 1);

const _windowBackgroundColor = Color.fromRGBO(55, 53, 59, 1);
const _windowBorderColor = Color.fromRGBO(78, 74, 82, 1);
const _windowBorderSide = BorderSide(color: _windowBorderColor);
const _windowBorder = Border.fromBorderSide(_windowBorderSide);
const windowBorderRadius = BorderRadius.all(Radius.circular(10));
final windowDecoration = BoxDecoration(
  color: _windowBackgroundColor,
  border: _windowBorder,
  borderRadius: windowBorderRadius,
  // TODO: this has quite some performance implications
  boxShadow: kElevationToShadow[4],
  //boxShadow: null,
);

// TitleBar
const titleBarIconSize = 14.0;
const titleBarIconsSpace = 8.0;
const titleBarPadding = EdgeInsets.fromLTRB(8, 6, 8, 8);
const titleBarTextColor = Color.fromRGBO(196, 196, 196, 1);
