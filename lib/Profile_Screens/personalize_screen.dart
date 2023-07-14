import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';

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
    // print("Selected repetitionMode: ${type.title}");
  }

  void _selectedAcademicIntervals(ClassTagItem type) {
    // print("Selected repetitionMode: ${type.title}");
  }

  void _selectedTaughtSession(ClassTagItem type) {
    // print("Selected repetitionMode: ${type.title}");
  }

  void _selectedDaysOffssion(ClassTagItem type) {
    // print("Selected repetitionMode: ${type.title}");
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
          itemCount: 6,
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
                    preselectedDateFormatIndex: personalSettings.settingsDateFormat
                  )
                ],
                if (index == 2) ...[
                  SelectPeronalizeOptions(
                    selectedEntry: _selectedTimeType,
                    selectionType: PersonalizeType.timeFormat,
                  )
                ],
                if (index == 3) ...[
                  SelectPeronalizeOptions(
                    selectedEntry: _selectedAcademicIntervals,
                    selectionType: PersonalizeType.academicIntervals,
                  )
                ],
                if (index == 4) ...[
                  SelectPeronalizeOptions(
                    selectedEntry: _selectedTaughtSession,
                    selectionType: PersonalizeType.sessionType,
                  )
                ],
                if (index == 5) ...[
                  SelectPeronalizeOptions(
                    selectedEntry: _selectedDaysOffssion,
                    selectionType: PersonalizeType.dayOffType,
                  )
                ],
              ],
            );
          },
        ),
      );
    });
  }
}
