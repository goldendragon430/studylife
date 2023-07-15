import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';
import '../Widgets/rounded_elevated_button.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../../Models/Services/storage_service.dart';
import '../Widgets/ProfileWidgets/select_country_picker.dart';
import '../Widgets/ProfileWidgets/select_dateFormat.dart';
import '../../Models/subjects_datasource.dart';
import '../Models/API/general_settings_model.dart';
import '../Networking/user_service.dart';
import '../Models/user.model.dart';

class PersonalizeScreen extends StatefulWidget {
  final Function userUpdated;
  final UserModel? currentUser;
  const PersonalizeScreen(
      {super.key, required this.userUpdated, this.currentUser});

  @override
  State<PersonalizeScreen> createState() => _PersonalizeScreenState();
}

class _PersonalizeScreenState extends State<PersonalizeScreen> {
  final ScrollController scrollcontroller = ScrollController();
  final StorageService _storageService = StorageService();
  PersonalSettingsModel personalSettings = PersonalSettingsModel();

  @override
  void initState() {
    setCurrentData();
    super.initState();
  }

  void setCurrentData() {
    if (widget.currentUser != null) {
      setState(() {
        if (widget.currentUser?.country != null) {
          personalSettings.country = widget.currentUser?.country;
        }

        if (widget.currentUser?.settingsDateFormat != null) {
          personalSettings.settingsDateFormat =
              widget.currentUser?.settingsDateFormat;
        }

        if (widget.currentUser?.timeFormat != null) {
          personalSettings.timeFormat = widget.currentUser?.timeFormat;
        }

        if (widget.currentUser?.settingsIs24Hour != null) {
          personalSettings.settingsIs24Hour =
              widget.currentUser?.settingsIs24Hour;
        }

        if (widget.currentUser?.settingsAcademicInterval != null) {
          personalSettings.settingsAcademicInterval =
              widget.currentUser?.settingsAcademicInterval;
        }

        if (widget.currentUser?.settingsSession != null) {
          personalSettings.settingsSession =
              widget.currentUser?.settingsSession;
        }

        if (widget.currentUser?.settingsDaysOff != null) {
          personalSettings.settingsDaysOff =
              widget.currentUser?.settingsDaysOff;
        }
      });
    }
  }

  void _countrySelected(String country) {
    personalSettings.country = country;
  }

  void _selectedDateType(ClassTagItem type) {
    personalSettings.settingsDateFormat = type.cardIndex;
  }

  void _selectedTimeType(ClassTagItem type) {
    if (type.cardIndex == 0) {
      personalSettings.timeFormat = "12";
    } else {
      personalSettings.timeFormat = "24";
    }
  }

  void _selectedAcademicIntervals(ClassTagItem type) {
    personalSettings.settingsAcademicInterval = type.title;
  }

  void _selectedTaughtSession(ClassTagItem type) {
    personalSettings.settingsSession = type.title;
  }

  void _selectedDaysOffssion(ClassTagItem type) {
    personalSettings.settingsDaysOff = type.title;
  }

  // API

  void updatePersonalSettings() async {
    LoadingDialog.show(context);

    try {
      var response = await UserService().updatePersonalization(
          personalSettings.country,
          personalSettings.settingsDateFormat,
          personalSettings.timeFormat,
          personalSettings.settingsAcademicInterval,
          personalSettings.settingsSession,
          personalSettings.settingsDaysOff);
      if (!context.mounted) return;
      LoadingDialog.hide(context);

      CustomSnackBar.show(
          context, CustomSnackBarType.success, response.data['message'], true);

      widget.userUpdated();
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], true);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", true);
      }
    }
  }

  void _saveSettings() {
    updatePersonalSettings();
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            "Personalize",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
        ),
        body: ListView.builder(
          controller: scrollcontroller,
          padding: const EdgeInsets.only(top: 30),
          itemCount: 7,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (index == 0) ...[
                  SelectCountryPicker(
                    countrySelected: _countrySelected,
                    preSelectedCountry: personalSettings.country,
                  )
                ],
                if (index == 1) ...[
                  Container(
                    height: 40,
                  ),
                  SelectPeronalizeOptions(
                      selectedEntry: _selectedDateType,
                      selectionType: PersonalizeType.dateFormat,
                      preselectedDateFormatIndex:
                          personalSettings.settingsDateFormat)
                ],
                if (index == 2) ...[
                  SelectPeronalizeOptions(
                    selectedEntry: _selectedTimeType,
                    selectionType: PersonalizeType.timeFormat,
                    is24HourFormat: personalSettings.settingsIs24Hour,
                  )
                ],
                if (index == 3) ...[
                  SelectPeronalizeOptions(
                      selectedEntry: _selectedAcademicIntervals,
                      selectionType: PersonalizeType.academicIntervals,
                      preelectedAcademicInterval:
                          personalSettings.settingsAcademicInterval)
                ],
                if (index == 4) ...[
                  SelectPeronalizeOptions(
                      selectedEntry: _selectedTaughtSession,
                      selectionType: PersonalizeType.sessionType,
                      preselectedSession: personalSettings.settingsSession)
                ],
                if (index == 5) ...[
                  SelectPeronalizeOptions(
                      selectedEntry: _selectedDaysOffssion,
                      selectionType: PersonalizeType.dayOffType,
                      preselectedDaysOffType: personalSettings.settingsDaysOff)
                ],
                if (index == 6) ...[
                  // Save/Cancel buttons
                  Container(
                    height: 68,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    // margin: const EdgeInsets.only(top: 260),
                    padding: const EdgeInsets.only(left: 106, right: 106),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RoundedElevatedButton(_saveSettings, "Save Task",
                            Constants.lightThemePrimaryColor, Colors.black, 45),
                        RoundedElevatedButton(
                            _cancel,
                            "Cancel",
                            Constants.blueButtonBackgroundColor,
                            Colors.white,
                            45)
                      ],
                    ),
                  ),
                  Container(
                    height: 88,
                  ),
                ],
              ],
            );
          },
        ),
      );
    });
  }
}
