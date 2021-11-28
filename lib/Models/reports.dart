import 'dart:convert';

Report offerFromJson(String str) => Report.fromJson(json.decode(str));

String offerToJson(Report data) => json.encode(data.toJson());

class Report {
  Report({
    required this.subject,
    required this.message,
  });

  String subject;
  String message;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    subject: json["subject"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "message": message,
  };
}
