class BankModel {
  BankModel({required this.name, required this.code});
  final String name;
  final String code;

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      name: json['name'],
      code: json['code'],
    );
  }
}
