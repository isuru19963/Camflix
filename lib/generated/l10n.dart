// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();

  static S current;

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();

      return S.current;
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home Page`
  String get homePageAppBarTitle {
    return Intl.message(
      'Home Page',
      name: 'homePageAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get homePageMainFormTitle {
    return Intl.message(
      'Personal Information',
      name: 'homePageMainFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get formFieldName {
    return Intl.message(
      'Name',
      name: 'formFieldName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get formFieldNameHint {
    return Intl.message(
      'Enter your name',
      name: 'formFieldNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get formFieldEmail {
    return Intl.message(
      'Email',
      name: 'formFieldEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get formFieldEmailHint {
    return Intl.message(
      'Enter your email',
      name: 'formFieldEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get formFieldDOB {
    return Intl.message(
      'Date of Birth',
      name: 'formFieldDOB',
      desc: '',
      args: [],
    );
  }

  /// `Required Field`
  String get formFieldRequired {
    return Intl.message(
      'Required Field',
      name: 'formFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Submit Info`
  String get formFieldSubmitInfo {
    return Intl.message(
      'Submit Info',
      name: 'formFieldSubmitInfo',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUsPageAppBarTitle {
    return Intl.message(
      'About Us',
      name: 'aboutUsPageAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsPageAppBarTitle {
    return Intl.message(
      'Settings',
      name: 'settingsPageAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get formFieldChangeLanguage {
    return Intl.message(
      'Change Language',
      name: 'formFieldChangeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `menuAppSetting`
  String get menuAppSetting {
    return Intl.message(
      'App Settings',
      name: 'menuAppSetting',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuNotifications {
    return Intl.message(
      'Notifications',
      name: 'menuNotifications',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuWatchHistory {
    return Intl.message(
      'Watch History',
      name: 'menuWatchHistory',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuAccount {
    return Intl.message(
      'Account',
      name: 'menuAccount',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuSubscribe {
    return Intl.message(
      'Subscribe',
      name: 'menuSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuFAQ {
    return Intl.message(
      'FAQ',
      name: 'menuFAQ',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuContactUs {
    return Intl.message(
      'Contact Us',
      name: 'menuContactUs',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuRateUs {
    return Intl.message(
      'Rate Us',
      name: 'menuRateUs',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuManageProfile {
    return Intl.message(
      'Manage Profile',
      name: 'menuManageProfile',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuShareApp {
    return Intl.message(
      'Share App',
      name: 'menuShareApp',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get menuSignOut {
    return Intl.message(
      'Sign Out',
      name: 'menuSignOut',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get welcomeText {
    return Intl.message(
      'Welcome to',
      name: 'welcomeText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get signWelcomeText {
    return Intl.message(
      'Sign in to Continue ',
      name: 'signWelcomeText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get loginWelcomeText {
    return Intl.message(
      'Login',
      name: 'loginWelcomeText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get registerWelcomeText {
    return Intl.message(
      'Register',
      name: 'registerWelcomeText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get loginpWelcomeText {
    return Intl.message(
      'Login to watch latest movies TV series, comedy shows and entertainment videos',
      name: 'loginpWelcomeText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get loginpemailText {
    return Intl.message(
      'Email',
      name: 'loginpemailText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get loginppasswordText {
    return Intl.message(
      'Password',
      name: 'loginppasswordText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get loginpsignupText {
    return Intl.message(
      'Signup',
      name: 'loginpsignupText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get loginpforgotpasswordText {
    return Intl.message(
      'Forgot Password?',
      name: 'loginpforgotpasswordText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get loginpdonthaveaccntText {
    return Intl.message(
      "If you Don't have an account",
      name: 'loginpdonthaveaccntText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get loginpalreadyhaveaccntText {
    return Intl.message(
      "Already have an account?",
      name: 'loginpalreadyhaveaccntText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get loginpsignInText {
    return Intl.message(
      'SIGN IN',
      name: 'loginpsignInText',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get regiterpwelcometext {
    return Intl.message(
      'Register to watch latest movies TV series, comedy shows and entertainment videos',
      name: 'regiterpwelcometext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get regiterpnametext {
    return Intl.message(
      'Name',
      name: 'regiterpnametext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get regiterpmobiletext {
    return Intl.message(
      'Mobile No',
      name: 'regiterpmobiletext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get videoDptext {
    return Intl.message(
      'Share',
      name: 'videoDptext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get videoWishlisttext {
    return Intl.message(
      'Wishlist',
      name: 'videoWishlisttext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get videoRatetext {
    return Intl.message(
      'Rate',
      name: 'videoRatetext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get videomoreliketext {
    return Intl.message(
      'MORE LIKE THIS',
      name: 'videomoreliketext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get videomoredetailstext {
    return Intl.message(
      'MORE DETAILS',
      name: 'videomoredetailstext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get searchFindtext {
    return Intl.message(
      "Search for a show, movie, etc.",
      name: 'searchFindtext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get searchFind1text {
    return Intl.message(
      'Find what to watch next.',
      name: 'searchFind1text',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get searchFind2text {
    return Intl.message(
      'Search for shows for the commute, movies to help unwind, or your go-to genres.',
      name: 'searchFind2text',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get wishlist1text {
    return Intl.message(
      'Add movies & TV shows to your list so you can easily find them later.',
      name: 'wishlist1text',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get wishlist2text {
    return Intl.message(
      'Find Something to watch',
      name: 'wishlist2text',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get Homebtext {
    return Intl.message(
      'Home',
      name: 'Homebtext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get Searchbtext {
    return Intl.message(
      'Search',
      name: 'Searchbtext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get Wishlistbtext {
    return Intl.message(
      'Home',
      name: 'Wishlistbtext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get Menubtext {
    return Intl.message(
      'Menu',
      name: 'Menubtext',
      desc: '',
      args: [],
    );
  }

  /// `menuNotifications`
  String get ViewAllbtext {
    return Intl.message(
      'View All',
      name: 'ViewAllbtext',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.`
  String get formFieldAbout {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
      name: 'formFieldAbout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      // Locale.fromSubtags(languageCode: 'ar', countryCode: 'SA'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
