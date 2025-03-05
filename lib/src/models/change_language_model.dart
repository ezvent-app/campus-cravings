class ChangeLanguageModel {
  final String title;
  final int index;
  final String flag;

  ChangeLanguageModel(
      {required this.title, required this.index, required this.flag});
}

List<ChangeLanguageModel> languagesList = [
  ChangeLanguageModel(title: 'Arabic', index: 0, flag: 'vt'),
  ChangeLanguageModel(title: 'Chinese', index: 1, flag: 'uk'),
  ChangeLanguageModel(title: 'Dutch', index: 2, flag: 'uk'),
  ChangeLanguageModel(title: 'English', index: 3, flag: 'uk'),
  ChangeLanguageModel(title: 'French', index: 4, flag: 'uk'),
  ChangeLanguageModel(title: 'German', index: 5, flag: 'uk'),
  ChangeLanguageModel(title: 'Hindi', index: 6, flag: 'uk'),
  ChangeLanguageModel(title: 'Italian', index: 7, flag: 'uk'),
  ChangeLanguageModel(title: 'Japanese', index: 8, flag: 'uk'),
  ChangeLanguageModel(title: 'Urdu', index: 9, flag: 'uk'),
  ChangeLanguageModel(title: 'Vietnamese', index: 10, flag: 'uk'),
];
