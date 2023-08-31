class QRCodeData {
  final String barCodeResults;
  final String email;
  final String name;

  QRCodeData({
    required this.barCodeResults,
    required this.email,
    required this.name
  });
  Map<String, dynamic> toJson() {
    return {
      'barCodeResults': barCodeResults,
      'email': email,
      'name': name
    };
  }
}