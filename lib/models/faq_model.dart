class FaqCategory {
  final int id;
  final String name;

  FaqCategory({required this.id, required this.name});

  factory FaqCategory.fromJson(Map<String, dynamic> json) {
    return FaqCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}
class SubCategoryFaq {
  final int id;
  final String name;
  final int faqCategoryId;

  SubCategoryFaq({
    required this.id,
    required this.name,
    required this.faqCategoryId,
  });

  factory SubCategoryFaq.fromJson(Map<String, dynamic> json) {
    return SubCategoryFaq(
      id: json['id'],
      name: json['name'],
      faqCategoryId: json['faq_category_id'],
    );
  }
}
