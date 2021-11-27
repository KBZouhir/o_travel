import 'dart:convert';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

String offerToJson(Offer data) => json.encode(data.toJson());

class Offer {
  Offer({
    required this.subject,
    required this.message,
  });

  String subject;
  String message;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    subject: json["subject"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "message": message,
  };
}
