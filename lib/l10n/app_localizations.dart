import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
    Locale('en')
  ];

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Your Campus. Your Cravings. Delivered.'**
  String get onboardingTitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Building Connections Beyond the Plate'**
  String get onboardingTitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Earn with Campus Cravings'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'By Students, For Students. Campus meals, snacks, and drinks—delivered to your dorm or class.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Campus Cravings isn\'t just delivery—it\'s community. Connect, share interests, and meet classmates with every order.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Earn cash by delivering and supporting your campus. Flexible hours, extra income, and helping classmates get their favorite meals.'**
  String get onboardingDesc3;

  /// No description provided for @signIntoAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your Account'**
  String get signIntoAccount;

  /// No description provided for @enterEmailAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password to log in'**
  String get enterEmailAndPassword;

  /// No description provided for @universityEmail.
  ///
  /// In en, this message translates to:
  /// **'University Email'**
  String get universityEmail;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password ?'**
  String get forgotPassword;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enterYourEmail;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @reEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter Password'**
  String get reEnterPassword;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account to continue!'**
  String get createAccount;

  /// No description provided for @selectUniversity.
  ///
  /// In en, this message translates to:
  /// **'Select University'**
  String get selectUniversity;

  /// No description provided for @setPassword.
  ///
  /// In en, this message translates to:
  /// **'Set Password'**
  String get setPassword;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyhaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyhaveAccount;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'We\'ve send you the verification code on'**
  String get sendVerificationCode;

  /// No description provided for @continueNext.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueNext;

  /// No description provided for @getCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Get code in'**
  String get getCodeIn;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @profileSetUp.
  ///
  /// In en, this message translates to:
  /// **'Profile Set-up'**
  String get profileSetUp;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter First Name'**
  String get enterFirstName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter Last Name'**
  String get enterLastName;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Select Role'**
  String get selectRole;

  /// No description provided for @registerForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Also Register for Delivery'**
  String get registerForDelivery;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @campusCravings.
  ///
  /// In en, this message translates to:
  /// **'Campus Cravings'**
  String get campusCravings;

  /// No description provided for @payoutMethod.
  ///
  /// In en, this message translates to:
  /// **'Payout Method'**
  String get payoutMethod;

  /// No description provided for @connectToStripe.
  ///
  /// In en, this message translates to:
  /// **'Connect Stripe'**
  String get connectToStripe;

  /// No description provided for @stripe.
  ///
  /// In en, this message translates to:
  /// **'Stripe'**
  String get stripe;

  /// No description provided for @studentProfileDetails.
  ///
  /// In en, this message translates to:
  /// **'Student Profile Details'**
  String get studentProfileDetails;

  /// No description provided for @batchYear.
  ///
  /// In en, this message translates to:
  /// **'Batch Year'**
  String get batchYear;

  /// No description provided for @yourMajors.
  ///
  /// In en, this message translates to:
  /// **'Your Major(s)'**
  String get yourMajors;

  /// No description provided for @yourMinors.
  ///
  /// In en, this message translates to:
  /// **'Your Minor(s)'**
  String get yourMinors;

  /// No description provided for @clubsOrganizations.
  ///
  /// In en, this message translates to:
  /// **'Clubs or Organizations you\'re involved in'**
  String get clubsOrganizations;

  /// No description provided for @aboutYou.
  ///
  /// In en, this message translates to:
  /// **'About You (Bio)'**
  String get aboutYou;

  /// No description provided for @whatDoYouWant.
  ///
  /// In en, this message translates to:
  /// **'What do you want people you deliver to know about you?'**
  String get whatDoYouWant;

  /// No description provided for @deliveryProfile.
  ///
  /// In en, this message translates to:
  /// **'Delivery Profile'**
  String get deliveryProfile;

  /// No description provided for @socialSecurityNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Social Security Number'**
  String get socialSecurityNumber;

  /// No description provided for @nationalID.
  ///
  /// In en, this message translates to:
  /// **'National ID / Proof of Work Permission'**
  String get nationalID;

  /// No description provided for @uploadCaptureImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Or Capture Image'**
  String get uploadCaptureImage;

  /// No description provided for @iAgreeWith.
  ///
  /// In en, this message translates to:
  /// **'I agree with '**
  String get iAgreeWith;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsConditions;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer: '**
  String get disclaimer;

  /// No description provided for @socialSecurityInfo.
  ///
  /// In en, this message translates to:
  /// **'Your Social Security Number and ID are required for background checks, work eligibility verification, and compliance with legal regulations, and will be securely stored as per our '**
  String get socialSecurityInfo;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @addPayoutDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Payout Details'**
  String get addPayoutDetails;

  /// No description provided for @selectBank.
  ///
  /// In en, this message translates to:
  /// **'Select Bank'**
  String get selectBank;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @enterOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Old Password'**
  String get enterOldPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'We highly recommend enabling notifications to stay updated on all your order statuses in real time.'**
  String get enableNotifications;

  /// No description provided for @smsNotifications.
  ///
  /// In en, this message translates to:
  /// **'SMS Notifications'**
  String get smsNotifications;

  /// No description provided for @enableSMSNotifications.
  ///
  /// In en, this message translates to:
  /// **'Stay in the loop! Enable SMS notifications to receive real-time updates about your order statuses.'**
  String get enableSMSNotifications;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @dontMissEmailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Don’t miss a thing! Turn on email notifications for detailed updates on all your orders.'**
  String get dontMissEmailNotifications;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching'**
  String get searching;

  /// No description provided for @placeYourOrderOnTheRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Placing your order on the restaurant'**
  String get placeYourOrderOnTheRestaurant;

  /// No description provided for @reachingOutToActiveStudentzNearby.
  ///
  /// In en, this message translates to:
  /// **'Reaching out to active students nearby!'**
  String get reachingOutToActiveStudentzNearby;

  /// No description provided for @slideToCancel.
  ///
  /// In en, this message translates to:
  /// **'       Slide to Cancel'**
  String get slideToCancel;

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @kCal.
  ///
  /// In en, this message translates to:
  /// **'Kcal'**
  String get kCal;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @m.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get m;

  /// No description provided for @noteToRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Note to Restaurant (optional)'**
  String get noteToRestaurant;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get less;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @chooseAnyoneFromTheOptions.
  ///
  /// In en, this message translates to:
  /// **'Choose anyone from the options'**
  String get chooseAnyoneFromTheOptions;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get promoCode;

  /// No description provided for @enterPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Promo Code'**
  String get enterPromoCode;

  /// No description provided for @size20Per.
  ///
  /// In en, this message translates to:
  /// **'E.g 20%DIS'**
  String get size20Per;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @mile.
  ///
  /// In en, this message translates to:
  /// **'Mile'**
  String get mile;

  /// No description provided for @miles.
  ///
  /// In en, this message translates to:
  /// **'Miles'**
  String get miles;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @away.
  ///
  /// In en, this message translates to:
  /// **'Away'**
  String get away;

  /// No description provided for @deliveryAvailable.
  ///
  /// In en, this message translates to:
  /// **'Delivery Available'**
  String get deliveryAvailable;

  /// No description provided for @pickedForYou.
  ///
  /// In en, this message translates to:
  /// **'Picked For You'**
  String get pickedForYou;

  /// No description provided for @savedAddresses.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get savedAddresses;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @defaultValue.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultValue;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @deliverwithUs.
  ///
  /// In en, this message translates to:
  /// **'Deliver with Us'**
  String get deliverwithUs;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @ssn.
  ///
  /// In en, this message translates to:
  /// **'Enter your ssn'**
  String get ssn;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @raiseATicket.
  ///
  /// In en, this message translates to:
  /// **'Raise a Ticket'**
  String get raiseATicket;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order details'**
  String get orderDetails;

  /// No description provided for @restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurant;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderNumber;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order summary'**
  String get orderSummary;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// No description provided for @imageSubmission.
  ///
  /// In en, this message translates to:
  /// **'Image Submission'**
  String get imageSubmission;

  /// No description provided for @reportAnIssue.
  ///
  /// In en, this message translates to:
  /// **'Report an issue'**
  String get reportAnIssue;

  /// No description provided for @referFriend.
  ///
  /// In en, this message translates to:
  /// **'Refer a Friend/s'**
  String get referFriend;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @addNewCard.
  ///
  /// In en, this message translates to:
  /// **'Add New Card'**
  String get addNewCard;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @expires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get expires;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @checkoutOrders.
  ///
  /// In en, this message translates to:
  /// **'Checkout Orders'**
  String get checkoutOrders;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickup;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessage;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @addTip.
  ///
  /// In en, this message translates to:
  /// **'Add a Tip'**
  String get addTip;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get subTotal;

  /// No description provided for @deliverTo.
  ///
  /// In en, this message translates to:
  /// **'Deliver to'**
  String get deliverTo;

  /// No description provided for @currentLiveLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Live Location'**
  String get currentLiveLocation;

  /// No description provided for @mapWidgetHere.
  ///
  /// In en, this message translates to:
  /// **'Map Widget Here'**
  String get mapWidgetHere;

  /// No description provided for @forDelivering.
  ///
  /// In en, this message translates to:
  /// **'For Delivering'**
  String get forDelivering;

  /// No description provided for @pickingUpYourorder.
  ///
  /// In en, this message translates to:
  /// **'Picking up your order...'**
  String get pickingUpYourorder;

  /// No description provided for @arrivingAt.
  ///
  /// In en, this message translates to:
  /// **'Arriving at '**
  String get arrivingAt;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @wantToLeaveTipFor.
  ///
  /// In en, this message translates to:
  /// **'Want to leave tip for'**
  String get wantToLeaveTipFor;

  /// No description provided for @reviewAboutService.
  ///
  /// In en, this message translates to:
  /// **'If you don’t mind, tell us how was service. This review will be used to improve our service to be better.'**
  String get reviewAboutService;

  /// No description provided for @howWasYourOrder.
  ///
  /// In en, this message translates to:
  /// **'How was your Order?'**
  String get howWasYourOrder;

  /// No description provided for @addDeliveryNote.
  ///
  /// In en, this message translates to:
  /// **'Add delivery note'**
  String get addDeliveryNote;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @deliveryDetails.
  ///
  /// In en, this message translates to:
  /// **'Delivery details'**
  String get deliveryDetails;

  /// No description provided for @deliveryComplete.
  ///
  /// In en, this message translates to:
  /// **'Delivery Complete'**
  String get deliveryComplete;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send a message'**
  String get sendMessage;

  /// No description provided for @yourOrderGoodHandsFellowComputerScienceStudent.
  ///
  /// In en, this message translates to:
  /// **'Your order is in good hands with a fellow Computer Science student!'**
  String get yourOrderGoodHandsFellowComputerScienceStudent;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @serviceRating.
  ///
  /// In en, this message translates to:
  /// **'Service rating'**
  String get serviceRating;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @educationDiscipline.
  ///
  /// In en, this message translates to:
  /// **'Education Discipline'**
  String get educationDiscipline;

  /// No description provided for @clubOrganizations.
  ///
  /// In en, this message translates to:
  /// **'Clubs or organizations'**
  String get clubOrganizations;

  /// No description provided for @enterBuilding.
  ///
  /// In en, this message translates to:
  /// **'Enter Building'**
  String get enterBuilding;

  /// No description provided for @enterFloor.
  ///
  /// In en, this message translates to:
  /// **'Enter Floor'**
  String get enterFloor;

  /// No description provided for @enterRoomNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Room Number'**
  String get enterRoomNumber;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @campusDelivery.
  ///
  /// In en, this message translates to:
  /// **'Campus Delivery'**
  String get campusDelivery;

  /// No description provided for @deliveryOrders.
  ///
  /// In en, this message translates to:
  /// **'Delivery Orders'**
  String get deliveryOrders;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// No description provided for @guaranteed.
  ///
  /// In en, this message translates to:
  /// **'Guaranteed'**
  String get guaranteed;

  /// No description provided for @mi.
  ///
  /// In en, this message translates to:
  /// **'mi'**
  String get mi;

  /// No description provided for @deliverBy.
  ///
  /// In en, this message translates to:
  /// **'Deliver by'**
  String get deliverBy;

  /// No description provided for @customerDropoff.
  ///
  /// In en, this message translates to:
  /// **'Customer Dropoff'**
  String get customerDropoff;

  /// No description provided for @navigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigation;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @slideToStartDelivery.
  ///
  /// In en, this message translates to:
  /// **'Slide to Start Delivery'**
  String get slideToStartDelivery;

  /// No description provided for @slideToEndDelivery.
  ///
  /// In en, this message translates to:
  /// **'Slide to End Delivery'**
  String get slideToEndDelivery;

  /// No description provided for @imageVerification.
  ///
  /// In en, this message translates to:
  /// **'Image Verification'**
  String get imageVerification;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @thankYouDeliveringOrderGreatJob.
  ///
  /// In en, this message translates to:
  /// **'Thank you for delivering the order! Great job!'**
  String get thankYouDeliveringOrderGreatJob;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @promotion.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get promotion;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add a Note'**
  String get addNote;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @saveAs.
  ///
  /// In en, this message translates to:
  /// **'Save as'**
  String get saveAs;

  /// No description provided for @setDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as Default'**
  String get setDefault;

  /// No description provided for @registerDelivery.
  ///
  /// In en, this message translates to:
  /// **'Register for Delivery'**
  String get registerDelivery;

  /// No description provided for @whatDoYouWantKnowAboutYou.
  ///
  /// In en, this message translates to:
  /// **'What do you want people you deliver to know about you?'**
  String get whatDoYouWantKnowAboutYou;

  /// No description provided for @addInstructionsToHelpDelivery.
  ///
  /// In en, this message translates to:
  /// **'Add Instruction to Help with Delivery (Optional)'**
  String get addInstructionsToHelpDelivery;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
