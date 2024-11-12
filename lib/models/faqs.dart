class Faq {
  final String question;

  Faq({required this.question});

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      question: json['question'],
    );
  }
}
