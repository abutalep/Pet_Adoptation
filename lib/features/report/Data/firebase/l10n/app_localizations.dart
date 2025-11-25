import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// The application name
  ///
  /// In en, this message translates to:
  /// **'Hope Paw'**
  String get appName;

  /// Title for language selection screen
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get chooseLanguage;

  /// Hint text for language selection
  ///
  /// In en, this message translates to:
  /// **'Select a language to continue'**
  String get selectLanguage;

  /// Continue button text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Title for report screen
  ///
  /// In en, this message translates to:
  /// **'Report Animal'**
  String get reportAnimal;

  /// Label for image upload section
  ///
  /// In en, this message translates to:
  /// **'Upload Animal Images (max 4)'**
  String get uploadImages;

  /// Label for animal status selection
  ///
  /// In en, this message translates to:
  /// **'Animal Status'**
  String get animalStatus;

  /// Lost status option
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get lost;

  /// Found status option
  ///
  /// In en, this message translates to:
  /// **'Found'**
  String get found;

  /// Label for animal type selection
  ///
  /// In en, this message translates to:
  /// **'Animal Type'**
  String get animalType;

  /// Hint for animal type dropdown
  ///
  /// In en, this message translates to:
  /// **'Select animal type'**
  String get selectAnimalType;

  /// Label for animal name field
  ///
  /// In en, this message translates to:
  /// **'Animal Name (Optional)'**
  String get animalName;

  /// Hint for animal name field
  ///
  /// In en, this message translates to:
  /// **'Enter animal name if known'**
  String get enterAnimalName;

  /// Label for animal color field
  ///
  /// In en, this message translates to:
  /// **'Animal Color *'**
  String get animalColor;

  /// Hint for animal color field
  ///
  /// In en, this message translates to:
  /// **'e.g., Brown, Black, White'**
  String get enterColor;

  /// Label for age field
  ///
  /// In en, this message translates to:
  /// **'Age (Optional)'**
  String get age;

  /// Label for reward field
  ///
  /// In en, this message translates to:
  /// **'Reward (Optional)'**
  String get reward;

  /// Label for user information section
  ///
  /// In en, this message translates to:
  /// **'Your Information *'**
  String get yourInformation;

  /// Label for user name field
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// Label for user email field
  ///
  /// In en, this message translates to:
  /// **'Your Email'**
  String get yourEmail;

  /// Label for description field
  ///
  /// In en, this message translates to:
  /// **'Description *'**
  String get description;

  /// Hint for description field
  ///
  /// In en, this message translates to:
  /// **'Add any additional details about the animal...'**
  String get addDescription;

  /// Label for location address field
  ///
  /// In en, this message translates to:
  /// **'Location Address *'**
  String get locationAddress;

  /// Hint for location address field
  ///
  /// In en, this message translates to:
  /// **'Enter the address where animal was lost/found'**
  String get enterAddress;

  /// Label for map section
  ///
  /// In en, this message translates to:
  /// **'Animal Location'**
  String get animalLocation;

  /// Label for coordinates section
  ///
  /// In en, this message translates to:
  /// **'Location Coordinates'**
  String get locationCoordinates;

  /// Label for latitude field
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// Label for longitude field
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// Button text for using current location
  ///
  /// In en, this message translates to:
  /// **'Use Current Location'**
  String get useCurrentLocation;

  /// Button text for submitting report
  ///
  /// In en, this message translates to:
  /// **'Add Animal'**
  String get addAnimal;

  /// Error message for missing images
  ///
  /// In en, this message translates to:
  /// **'Please upload images'**
  String get pleaseUploadImages;

  /// Error message for missing status
  ///
  /// In en, this message translates to:
  /// **'Please select Lost or Found'**
  String get pleaseSelectStatus;

  /// Error message for missing location
  ///
  /// In en, this message translates to:
  /// **'Please pick a location'**
  String get pleasePickLocation;

  /// Error message for missing animal type
  ///
  /// In en, this message translates to:
  /// **'Please select animal type'**
  String get pleaseSelectAnimalType;

  /// Error message for missing color
  ///
  /// In en, this message translates to:
  /// **'Please enter animal color'**
  String get pleaseEnterColor;

  /// Error message for missing name
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// Error message for missing email
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// Error message for missing description
  ///
  /// In en, this message translates to:
  /// **'Please enter description'**
  String get pleaseEnterDescription;

  /// Error message for missing address
  ///
  /// In en, this message translates to:
  /// **'Please enter location address'**
  String get pleaseEnterAddress;

  /// Success message after submitting report
  ///
  /// In en, this message translates to:
  /// **'Report added successfully'**
  String get reportAddedSuccessfully;

  /// Error message when report submission fails
  ///
  /// In en, this message translates to:
  /// **'Failed to submit report'**
  String get failedToSubmitReport;

  /// Error message for missing location permission
  ///
  /// In en, this message translates to:
  /// **'Location permission is required'**
  String get locationPermissionRequired;

  /// Dog animal type
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get dog;

  /// Cat animal type
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get cat;

  /// Bird animal type
  ///
  /// In en, this message translates to:
  /// **'Bird'**
  String get bird;

  /// Other animal type
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
