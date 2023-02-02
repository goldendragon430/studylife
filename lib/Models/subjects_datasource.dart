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
}
