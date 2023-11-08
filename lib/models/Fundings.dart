class Fundings {
  final int id;
  final String title;
  final String image;
  final int target_amount;
  final int current_amount;
  final double percetageProgress;

  Fundings({
    required this.id,
    required this.title,
    required this.image,
    required this.target_amount,
    required this.current_amount,
    required this.percetageProgress,
  });

  factory Fundings.fromJson(Map<String, dynamic> json) {
    return Fundings(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      target_amount: json['target_amount'],
      current_amount: json['current_amount'],
      percetageProgress: json['percentange_succcess'] / 100,
    );
  }
}
