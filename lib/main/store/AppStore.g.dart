// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on AppStoreBase, Store {
  final _$isDarkModeOnAtom = Atom(name: 'AppStoreBase.isDarkModeOn');

  @override
  bool get isDarkModeOn {
    _$isDarkModeOnAtom.reportRead();
    return super.isDarkModeOn;
  }

  @override
  set isDarkModeOn(bool value) {
    _$isDarkModeOnAtom.reportWrite(value, super.isDarkModeOn, () {
      super.isDarkModeOn = value;
    });
  }

  final _$isLoggedInAtom = Atom(name: 'AppStoreBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$cardColorAtom = Atom(name: 'AppStoreBase.cardColor');

  @override
  Color get cardColor {
    _$cardColorAtom.reportRead();
    return super.cardColor;
  }

  // final _$favDeviceListAtom = Atom(name: 'AppStoreBase.favDeviceList');
  // final _$hsUserProfileListAtom = Atom(name: 'AppStoreBase.hsUserProfileList');

  final _$toggleDarkModeAsyncAction =
      AsyncAction('AppStoreBase.toggleDarkMode');

  @override
  Future<void> toggleDarkMode({bool? value}) {
    return _$toggleDarkModeAsyncAction
        .run(() => super.toggleDarkMode(value: value));
  }

  final _$AppStoreBaseActionController = ActionController(name: 'AppStoreBase');

  @override
  void setLoggedIn(bool val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setLoggedIn');
    try {
      return super.setLoggedIn(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkModeOn: ${isDarkModeOn},
isLoggedIn: ${isLoggedIn},
cardColor: ${cardColor},
    ''';
  }
}
