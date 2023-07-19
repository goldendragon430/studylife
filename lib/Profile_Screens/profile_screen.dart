import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:my_study_life_flutter/Widgets/ProfileWidgets/collection_widget_four_items.dart';
import 'package:beamer/beamer.dart';
import '../Models/Services/storage_service.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

import '../../app.dart';
import '../Controllers/auth_notifier.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Profile_Screens/profile_screen.dart';
import '../Widgets/ProfileWidgets/edit_list.dart';
import '../Widgets/ProfileWidgets/personalization_list.dart';
import '../Widgets/ProfileWidgets/most_least_practiced_subject.dart';
import '../Widgets/rounded_elevated_button.dart';
import '../../Models/profile_datasource.dart';
import '../../Profile_Screens/manage_subjects_screen.dart';
import '../../Profile_Screens/change_email_screen.dart';
import '../Profile_Screens/change_password_screen.dart';
import './general_settings_screen.dart';
import '../Models/user.model.dart';
import '../Models/API/task.dart';
import '../Profile_Screens/edit_profile_screen.dart';
import './reminder_notifications_screen.dart';
import './personalize_screen.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import '../Networking/user_service.dart';
import '../Models/API/practicedSubject.dart';
import './subscription_screen.dart';
import '../Widgets/ProfileWidgets/policy_and_terms_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<ProfileItemStatic> _itemsPersonalize =
      ProfileItemStatic.personalizationItems;
  final List<ProfileItemStatic> _itemsEdit = ProfileItemStatic.editItems;
  final List<ProfileItemStatic> _tcItems = ProfileItemStatic.tcItems;

  final StorageService _storageService = StorageService();
  List<Task> _tasks = [];
  List<Task> _tasksTotal = [];
  List<Task> _tasksPast = [];

  String userName = '';
  String email = '';
  String imageUrl = '';
  UserModel? editedUser;
  int tasksCompleted = 0;
  int yourStreak = 0;
  int mostPracticedSubjectTasksCount = 0;
  int leastPracticedSubjectTasksCount = 0;
  PracticedSubject mostPracticedSubject = PracticedSubject();
  PracticedSubject leastPracticedSubject = PracticedSubject();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _getData();
    });
  }

  void _getData() async {
    var userString = await _storageService.readSecureData("activeUser");

    var mostPracticedSubjecterString =
        await _storageService.readSecureData("most_practiced_subject");
    var leastPracticedSubjecterString =
        await _storageService.readSecureData("least_practiced_subject");

    // Get Tasks from storage
    var tasksData = await _storageService.readSecureData("user_tasks");

    List<dynamic> decodedDataTasks = jsonDecode(tasksData ?? "");

    var taskDataCurrent =
        await _storageService.readSecureData("user_tasks_current");

    List<dynamic> decodedDataTasksCurrent = jsonDecode(taskDataCurrent ?? "");

    var taskDataOverdue =
        await _storageService.readSecureData("user_tasks_past");

    List<dynamic> decodedDataTasksOverdue = jsonDecode(taskDataOverdue ?? "");

    var tasksCompletedString =
        await _storageService.readSecureData("tasks_completed");

    if (tasksCompletedString != null) {
      tasksCompleted = int.parse(tasksCompletedString);
    }
    var yourStreakString = await _storageService.readSecureData("your_streak");
    if (yourStreakString != null) {
      yourStreak = int.parse(yourStreakString);
    }
    var mostPracticedSubjectTasksCountString =
        await _storageService.readSecureData("most_practiced_tasks_count");

    if (mostPracticedSubjectTasksCountString != null) {
      mostPracticedSubjectTasksCount =
          int.parse(mostPracticedSubjectTasksCountString);
    }

    var leastPracticedSubjectTasksCountString =
        await _storageService.readSecureData("least_practiced_tasks_count");
    if (leastPracticedSubjectTasksCountString != null) {
      leastPracticedSubjectTasksCount =
          int.parse(leastPracticedSubjectTasksCountString);
    }

    if (userString != null && userString.isNotEmpty) {
      Map<String, dynamic> userMap = jsonDecode(userString);

      var user = UserModel.fromJson(userMap);
      editedUser = user;

      if (mostPracticedSubjecterString != null) {
        Map<String, dynamic> mostPracticedSubjectMap =
            jsonDecode(mostPracticedSubjecterString);
        mostPracticedSubject =
            PracticedSubject.fromJson(mostPracticedSubjectMap);
      }

      if (leastPracticedSubjecterString != null) {
        Map<String, dynamic> leastPracticedSubjectMap =
            jsonDecode(leastPracticedSubjecterString);
        leastPracticedSubject =
            PracticedSubject.fromJson(leastPracticedSubjectMap);
      }

      setState(() {
        userName = "${user.firstName} ${user.lastName}";
        email = user.email ?? "";
        imageUrl = user.profileImageUrl ?? "";

        _tasks = List<Task>.from(
          decodedDataTasks.map((x) => Task.fromJson(x as Map<String, dynamic>)),
        );
        _tasksTotal = List<Task>.from(
          decodedDataTasksCurrent
              .map((x) => Task.fromJson(x as Map<String, dynamic>)),
        );
        _tasksPast = List<Task>.from(
          decodedDataTasksOverdue
              .map((x) => Task.fromJson(x as Map<String, dynamic>)),
        );
      });
    }
  }

  void generalSettingsUpdated() {
    // Navigator.pop(context);
    userUpdated();
  }

  void userUpdated() async {
    // LoadingDialog.show(context);

    try {
      var response = await UserService().getUser();

      // if (!context.mounted) return;

      // var userString = await _storageService.readSecureData("activeUser");
      var user = UserModel.fromJson(response.data['user']);
      if (response.data['tasksCompleted'] != null) {
        tasksCompleted = response.data['tasksCompleted'];
      }
      if (response.data['streak'] != null) {
        yourStreak = response.data['streak'];
      }
      if (response.data['mostPracticedSubjectTasksThisMonth'] != null) {
        mostPracticedSubjectTasksCount =
            response.data['mostPracticedSubjectTasksThisMonth'];
      }
      if (response.data['leastPracticedSubjectTasksThisMonth'] != null) {
        leastPracticedSubjectTasksCount =
            response.data['leastPracticedSubjectTasksThisMonth'];
      }

      editedUser = user;
      if (response.data['mostPracticedSubject'] != null &&
          response.data['leastPracticedSubject'] != null) {
        var mostPracticed =
            PracticedSubject.fromJson(response.data['mostPracticedSubject']);
        var leastPracticed =
            PracticedSubject.fromJson(response.data['leastPracticedSubject']);
        mostPracticedSubject = mostPracticed;
        leastPracticedSubject = leastPracticed;
      }

      setState(() {
        userName = "${user.firstName} ${user.lastName}";
        email = user.email ?? "";
        imageUrl = user.profileImageUrl ?? "";
        Navigator.pop(context);

        // LoadingDialog.hide(context);
        // CustomSnackBar.show(context, CustomSnackBarType.success,
        //     response.data['message'], true);
      });
    } catch (error) {
      if (error is DioError) {
        //   LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], true);
      } else {
        // LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", true);
      }
    }
  }

  void deleteUserAccount() async {
    LoadingDialog.show(context);

    try {
      var response = await UserService().deleteUser();

      if (!context.mounted) return;

      LoadingDialog.hide(context);
      CustomSnackBar.show(
          context, CustomSnackBarType.success, response.data['message'], true);
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

  void _selectedGridCard(int index) {
    print("Selected Grid card with Index: $index");
  }

  void _selectedPersonalizationCard(int index) {
    if (index == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ManageSubjectsScreen(),
              fullscreenDialog: false));
    }
    if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PersonalizeScreen(
                    userUpdated: generalSettingsUpdated,
                    currentUser: editedUser,
                  ),
              fullscreenDialog: false));
    }
    if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GeneralSettingsScreen(
                    currentUser: editedUser,
                    userUpdated: generalSettingsUpdated,
                  ),
              fullscreenDialog: false));
    }
    if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReminderNotificationsScreen(
                    currentUser: editedUser,
                    notificationsSettingsUpdated: userUpdated,
                  ),
              fullscreenDialog: false));
    }
    if (index == 4) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SubscriptionScreen(),
              fullscreenDialog: true));
    }
    if (index == 5) {
      // Intercom
      openIntercomMessenger();
    }
  }

  void openIntercomMessenger() async {
    await Intercom.instance.displayMessages();
  }

  void _selectedEditListCard(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeEmailScreen(editedUser),
            fullscreenDialog: true),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(),
            fullscreenDialog: true),
      );
    }
    print("Selected Personalization card with Index: $index");
  }

  Future<void> _selectedPolicyTermsCard(int index) async {
    if (index == 0) {
      final Uri _url = Uri.parse('https://mystudylife.com/terms-of-service/');
      _launchUrl(_url);
    }
    if (index == 1) {
      final Uri _url = Uri.parse('https://mystudylife.com/privacy-policy/');
      _launchUrl(_url);
    }
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _logOutButtonTapped(WidgetRef ref) async {
    await ref.read(authProvider.notifier).logoutUser();

    final currentContext = scaffoldMessengerKey.currentContext!;

    if (!currentContext.mounted) return;

    Beamer.of(currentContext).update();
  }

  void _deleteAccountButtonTapped() {
    deleteUserAccount();
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
            "Profile",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
          actions: [
            // Navigate to the Search Screen
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                              editedUser: editedUser,
                              userUpdated: userUpdated,
                            ),
                        fullscreenDialog: true));
              },
              child: Text(
                'Edit',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeNavigationButtonStyle
                    : Constants.darkThemeNavigationButtonStyle,
              ),
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.topCenter,
          height: double.infinity,
          child: ListView.builder(
              // controller: widget._controller,
              itemCount: 13,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Container(
                      margin: const EdgeInsets.only(top: 21),
                      height: 146,
                      width: 146,
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        color: theme == ThemeMode.light
                            ? Constants.lightThemeProfileImageCntainerColor
                            : Constants.darkThemeProfileImageCntainerColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 7,
                            color: theme == ThemeMode.light
                                ? Constants.lightThemeProfileImageCntainerColor
                                : Constants.darkThemeProfileImageCntainerColor),
                        image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: NetworkImage(imageUrl),
                        ),
                      ),
                      // child: Container(
                      //   margin: EdgeInsets.all(4),
                      //   height: 142,
                      //   width: 142,
                      //   child: ClipRRect(
                      //     borderRadius:
                      //         BorderRadius.circular(71), // Image border
                      //     child: Image.network(
                      //       fit: BoxFit.fill,
                      //       imageUrl,
                      //       height: 142,
                      //       width: 143,
                      //     ),
                      //   ),
                      // ),
                    );
                  case 1:
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 14),
                      child: Text(
                        userName,
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Constants.lightThemeTextSelectionColor
                                : Colors.white),
                      ),
                    );
                  case 2:
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(email,
                          style: theme == ThemeMode.light
                              ? Constants.socialLoginLightButtonTextStyle
                              : Constants.socialLoginDarkButtonTextStyle),
                    );
                  case 3:
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 38),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: 4,
                        itemBuilder: (ctx, i) {
                          switch (i) {
                            case 0:
                              return CollectionWidgetFourItems(
                                title: "Pending Tasks",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Next 7 days",
                                numberFirst: _tasks.length,
                                isOverdue: false,
                                isPending: true,
                                numberSecond: 10,
                                isTasksOrStreak: false,
                              );
                            case 1:
                              return CollectionWidgetFourItems(
                                title: "Overdue Tasks",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Total",
                                numberFirst: _tasksPast.length,
                                isOverdue: true,
                                isPending: false,
                                isTasksOrStreak: false,
                              );
                            case 2:
                              return CollectionWidgetFourItems(
                                title: "Tasks Completed",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Last 7 days",
                                numberFirst: tasksCompleted,
                                isOverdue: false,
                                isPending: false,
                                isTasksOrStreak: true,
                              );
                            case 3:
                              return CollectionWidgetFourItems(
                                title: "Your Streak",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Days with no tasks\ngoing late",
                                numberFirst: yourStreak,
                                isOverdue: false,
                                isPending: false,
                                isTasksOrStreak: true,
                              );
                            default:
                          }
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 149,
                        ),
                      ),
                    );
                  case 4:
                    return MostLeastPracticedSubject(
                        cardIndex: 0,
                        cardselected: () => {},
                        mostPracticedSubject:
                            mostPracticedSubject.subject?.subjectName ?? "",
                        mostPracticedSubjectColor:
                            mostPracticedSubject.subject?.colorHex != null
                                ? HexColor.fromHex(
                                    mostPracticedSubject.subject!.colorHex!)
                                : Colors.red,
                        mostPracticedSubjectTasksCount:
                            mostPracticedSubjectTasksCount,
                        leastPracticedSubject:
                            leastPracticedSubject.subject?.subjectName ?? "",
                        leastPracticedSubjectColor:
                            leastPracticedSubject.subject?.colorHex != null
                                ? HexColor.fromHex(
                                    leastPracticedSubject.subject!.colorHex!)
                                : Colors.red,
                        leastPracticedSubjectTasksCount:
                            leastPracticedSubjectTasksCount);
                  case 5:
                    return Container(
                      margin: EdgeInsets.only(top: 33, bottom: 28),
                      child: Container(
                        height: 1,
                        color: theme == ThemeMode.light
                            ? Colors.black.withOpacity(0.1)
                            : Colors.white.withOpacity(0.1),
                      ),
                    );
                  case 6:
                    return PersonalizationList(
                        _selectedPersonalizationCard, _itemsPersonalize);
                  case 7:
                    return Container(
                      margin: EdgeInsets.only(top: 33, bottom: 28),
                      child: Container(
                        height: 1,
                        color: theme == ThemeMode.light
                            ? Colors.black.withOpacity(0.1)
                            : Colors.white.withOpacity(0.1),
                      ),
                    );
                  case 8:
                    return EditList(_selectedEditListCard, _itemsEdit);
                  case 9:
                    return Container(
                      margin: EdgeInsets.only(top: 33, bottom: 28),
                      child: Container(
                        height: 1,
                        color: theme == ThemeMode.light
                            ? Colors.black.withOpacity(0.1)
                            : Colors.white.withOpacity(0.1),
                      ),
                    );
                  case 10:
                    return PolicyAndTermsList(
                        _selectedPolicyTermsCard, _tcItems);

                  case 11:
                    return Container(
                      alignment: Alignment.topCenter,
                      width: 142,
                      margin: const EdgeInsets.only(
                          top: 44, bottom: 57, left: 116, right: 116),
                      child: RoundedElevatedButton(
                          () => _logOutButtonTapped(ref),
                          "Log Out",
                          Constants.logOutButtonColor,
                          Colors.black,
                          34),
                    );
                  case 12:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 1,
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(0.1)
                              : Colors.white.withOpacity(0.1),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          // width: 142,
                          margin: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: _deleteAccountButtonTapped,
                            child: Text(
                              "Delete Account",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                  color: Constants.overdueTextColor),
                            ),
                          ),
                        ),
                      ],
                    );
                  default:
                }
              }),
        ),
      );
    });
  }
}
