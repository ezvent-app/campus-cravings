class FAQModel {
  final String name, description;

  FAQModel({required this.name, required this.description});
}

List<FAQModel> helpOrderModelList = [
  FAQModel(
    name: 'How can I cancel my order?',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  FAQModel(
    name: 'How can I delete my account?',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
];
