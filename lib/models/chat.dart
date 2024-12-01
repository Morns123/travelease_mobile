class Node {
  final int id;
  final String question;
  final String buttonText;
  final String answer;
  final int? parentId;

  Node({
    required this.id,
    required this.question,
    required this.buttonText,
    required this.answer,
    this.parentId,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      id: json['id'],
      question: json['question'],
      buttonText: json['button_text'],
      answer: json['answer'],
      parentId: json['parent_id'],
    );
  }
}
