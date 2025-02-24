class ChangeLanguageModel {
  final String title;
  final int index;
  final String flag;

  ChangeLanguageModel(
      {required this.title, required this.index, required this.flag});
}

List<ChangeLanguageModel> languagesList = [
  ChangeLanguageModel(title: 'Vietnamese', index: 0, flag: 'vt'),
  ChangeLanguageModel(title: 'English', index: 1, flag: 'uk'),
];
