class FAQModel {
  final String name, description;

  FAQModel({required this.name, required this.description});
}

// Order Section
List<FAQModel> orderFaqList = [
  FAQModel(
    name: 'Can I order from multiple restaurants at once?',
    description:
        'For now, you can only order from one place at a time per order.',
  ),
  FAQModel(
    name: 'Will I get a receipt?',
    description: 'Yes! You\'ll receive a receipt with your order.',
  ),
  FAQModel(
    name: 'Is there a minimum order amount?',
    description:
        'Nope! Order as little or as much as you\'d like—no minimum required.',
  ),
  FAQModel(
    name: 'Can I customize my order?',
    description:
        'Yes! You can choose size, add-ons, and leave special instructions.',
  ),
];

// Delivery Section
List<FAQModel> deliveryFaqList = [
  FAQModel(
    name: 'Where can I get my order delivered?',
    description:
        'Anywhere on campus—your dorm, classroom, library, or even outdoors.',
  ),
  FAQModel(
    name: 'Who delivers the food?',
    description:
        'Fellow students! All couriers are verified and part of your campus community.',
  ),
  FAQModel(
    name: 'Can I track my delivery?',
    description: 'Yes! Use the live map and status updates in the app.',
  ),
  FAQModel(
    name: 'Can I contact my courier?',
    description:
        'Yes, a chat or call option is available once your order is picked up.',
  ),
  FAQModel(
    name: 'Is there a delivery fee?',
    description:
        "Yes, a small delivery fee applies. You'll see it clearly at checkout before placing your order.",
  ),
];

// Payment Section
List<FAQModel> paymentFaqList = [
  FAQModel(
    name: 'What payment methods can I use?',
    description: 'We accept debit/credit cards, Apple Pay, and Stripe.',
  ),
  FAQModel(
    name: 'Is my payment info safe?',
    description:
        'Absolutely. We use secure, encrypted systems to keep your data protected.',
  ),
  FAQModel(
    name: 'Can I use campus meal credits or dining dollars?',
    description: 'Not yet, but we’re working on it.',
  ),
  FAQModel(
    name: 'Can I split payments with a friend?',
    description: 'Right now, one person pays per order.',
  ),
  FAQModel(
    name: 'What if my payment fails?',
    description:
        'You’ll get a prompt to try another method. No charge will go through until the payment is confirmed.',
  ),
];

// Account Section
List<FAQModel> accountFaqList = [
  FAQModel(
    name: 'Can I update my personal info?',
    description: 'Yes! Go to your profile to edit name, phone, more.',
  ),
  FAQModel(
    name: 'What if I forget my password?',
    description:
        'Tap “Forgot Password” on the login screen and follow the steps to reset.',
  ),
  FAQModel(
    name: 'Can I delete my account?',
    description:
        'You can request account deletion by contacting our support team.',
  ),
  FAQModel(
    name: 'How do I become a delivery person?',
    description:
        'Go to the Campus Delivery tab in the app and tap the “Register for Delivery” button.',
  ),
  FAQModel(
    name: 'Can I view my delivery or earning history?',
    description:
        'Yes, the Order History tab shows all your previous orders. If you’re a courier, your earnings history can be found in the Campus Delivery tab.',
  ),
];
