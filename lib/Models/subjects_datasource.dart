class ClassTagItem {
  final String title;
  bool selected;
  bool isAddNewCard;

  final int cardIndex;

  ClassTagItem({
    required this.title,
    required this.selected,
    required this.isAddNewCard,
    required this.cardIndex,
  });

  static List<ClassTagItem> subjects = [
    ClassTagItem(
        title: "Math", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Chemistry", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Biology", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "Physics", selected: false, isAddNewCard: false, cardIndex: 3),
    ClassTagItem(
        title: "Computer Science",
        selected: false,
        isAddNewCard: false,
        cardIndex: 4),
    ClassTagItem(
        title: "+ Add New", selected: false, isAddNewCard: true, cardIndex: 5),
  ];

  static List<ClassTagItem> subjectModes = [
    ClassTagItem(
        title: "In Person", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Online", selected: false, isAddNewCard: false, cardIndex: 1),
  ];

  static List<ClassTagItem> repetitionModes = [
    ClassTagItem(
        title: "Once", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Repeating", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Rotational",
        selected: false,
        isAddNewCard: false,
        cardIndex: 2),
  ];

  static List<ClassTagItem> classDays = [
    ClassTagItem(
        title: "Mon", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Tue", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Wed", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "Thu", selected: false, isAddNewCard: false, cardIndex: 3),
    ClassTagItem(
        title: "Fri", selected: false, isAddNewCard: false, cardIndex: 4),
    ClassTagItem(
        title: "Sut", selected: false, isAddNewCard: false, cardIndex: 5),
    ClassTagItem(
        title: "Sun", selected: false, isAddNewCard: false, cardIndex: 6)
  ];

  static List<ClassTagItem> examTypes = [
    ClassTagItem(
        title: "Exam", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Quiz", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Test", selected: false, isAddNewCard: false, cardIndex: 2),
  ];
}
