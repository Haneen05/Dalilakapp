// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Dalilak`
  String get appTitle {
    return Intl.message(
      'Dalilak',
      name: 'appTitle',
      desc: 'The name of the application',
      args: [],
    );
  }

  /// `Find It All in One... Your Ultimate Services Solution!`
  String get findItAll {
    return Intl.message(
      'Find It All in One... Your Ultimate Services Solution!',
      name: 'findItAll',
      desc: 'App tagline',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: 'Title for the categories section',
      args: [],
    );
  }

  /// `Featured`
  String get featured {
    return Intl.message(
      'Featured',
      name: 'featured',
      desc: 'Featured section title',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: 'Offers section title',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: 'Profile section title',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Login button text',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Settings menu item',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'Language selection option',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: 'Label for English language',
      args: [],
    );
  }

  /// `العربية`
  String get arabic {
    return Intl.message(
      'العربية',
      name: 'arabic',
      desc: 'Label for Arabic language',
      args: [],
    );
  }

  /// `Language Settings`
  String get languageSettings {
    return Intl.message(
      'Language Settings',
      name: 'languageSettings',
      desc: 'Title for language settings screen',
      args: [],
    );
  }

  /// `User Info`
  String get userInfo {
    return Intl.message(
      'User Info',
      name: 'userInfo',
      desc: 'User information section title',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: 'Label for user name field',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: 'Label for phone number field',
      args: [],
    );
  }

  /// `Select Gender`
  String get selectGender {
    return Intl.message(
      'Select Gender',
      name: 'selectGender',
      desc: 'Label for gender selection',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: 'Gender field placeholder',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Text for cancel button',
      args: [],
    );
  }

  /// `Save Profile`
  String get saveProfile {
    return Intl.message(
      'Save Profile',
      name: 'saveProfile',
      desc: 'Text for save profile button',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'Text for logout button',
      args: [],
    );
  }

  /// `Not logged in`
  String get notLoggedIn {
    return Intl.message(
      'Not logged in',
      name: 'notLoggedIn',
      desc: 'Message shown when user is not logged in',
      args: [],
    );
  }

  /// `Top Offers`
  String get topOffers {
    return Intl.message(
      'Top Offers',
      name: 'topOffers',
      desc: 'Title for the top offers section',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: 'Button text to view all categories',
      args: [],
    );
  }

  /// `Dalilak`
  String get dalilak {
    return Intl.message(
      'Dalilak',
      name: 'dalilak',
      desc: 'App name',
      args: [],
    );
  }

  /// `Find It All in One ... Your Ultimate Services Solution!`
  String get searchBoxTitle {
    return Intl.message(
      'Find It All in One ... Your Ultimate Services Solution!',
      name: 'searchBoxTitle',
      desc: 'Title for the search box',
      args: [],
    );
  }

  /// `Near You`
  String get nearYou {
    return Intl.message(
      'Near You',
      name: 'nearYou',
      desc: 'Title for the near you section',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: 'Label for name field',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Label for email field',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: 'Label for message field',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: 'Text for send button',
      args: [],
    );
  }

  /// `Code expires in `
  String get codeExpiresIn {
    return Intl.message(
      'Code expires in ',
      name: 'codeExpiresIn',
      desc: 'Message indicating the time remaining for the OTP code',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `My List`
  String get myList {
    return Intl.message(
      'My List',
      name: 'myList',
      desc: '',
      args: [],
    );
  }

  /// `Reach Out, We're Just a Tap Away!`
  String get reachOut {
    return Intl.message(
      'Reach Out, We\'re Just a Tap Away!',
      name: 'reachOut',
      desc: '',
      args: [],
    );
  }

  /// `Drop us a line`
  String get dropLine {
    return Intl.message(
      'Drop us a line',
      name: 'dropLine',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Operating Hours`
  String get operatingHours {
    return Intl.message(
      'Operating Hours',
      name: 'operatingHours',
      desc: '',
      args: [],
    );
  }

  /// `Contact Info`
  String get contactInfo {
    return Intl.message(
      'Contact Info',
      name: 'contactInfo',
      desc: '',
      args: [],
    );
  }

  /// `portfolio`
  String get portfolio {
    return Intl.message(
      'portfolio',
      name: 'portfolio',
      desc: '',
      args: [],
    );
  }

  /// `Rating & Reviews`
  String get ratingAndReviews {
    return Intl.message(
      'Rating & Reviews',
      name: 'ratingAndReviews',
      desc: '',
      args: [],
    );
  }

  /// `Write a Review`
  String get writeReview {
    return Intl.message(
      'Write a Review',
      name: 'writeReview',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Nothing to show yet`
  String get oops {
    return Intl.message(
      'Oops! Nothing to show yet',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `Find your saved storefronts here`
  String get findSavedStorefronts {
    return Intl.message(
      'Find your saved storefronts here',
      name: 'findSavedStorefronts',
      desc: '',
      args: [],
    );
  }

  /// `Clear All`
  String get clearAll {
    return Intl.message(
      'Clear All',
      name: 'clearAll',
      desc: '',
      args: [],
    );
  }

  /// `Previous Search`
  String get previousSearch {
    return Intl.message(
      'Previous Search',
      name: 'previousSearch',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Ascending`
  String get ascending {
    return Intl.message(
      'Ascending',
      name: 'ascending',
      desc: '',
      args: [],
    );
  }

  /// `Descending`
  String get descending {
    return Intl.message(
      'Descending',
      name: 'descending',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Sub-Category`
  String get subCategory {
    return Intl.message(
      'Sub-Category',
      name: 'subCategory',
      desc: '',
      args: [],
    );
  }

  /// `Search For a Sub Catg.`
  String get searchForSubCategory {
    return Intl.message(
      'Search For a Sub Catg.',
      name: 'searchForSubCategory',
      desc: '',
      args: [],
    );
  }

  /// `Apply Filters`
  String get applyFilters {
    return Intl.message(
      'Apply Filters',
      name: 'applyFilters',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `{distance} Km`
  String distance(Object distance) {
    return Intl.message(
      '$distance Km',
      name: 'distance',
      desc: '',
      args: [distance],
    );
  }

  /// `away`
  String get statusAway {
    return Intl.message(
      'away',
      name: 'statusAway',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
