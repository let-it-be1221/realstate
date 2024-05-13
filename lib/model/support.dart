// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Support {
  String name;
  String email;
  String subject;
  Support({
    required this.name,
    required this.email,
    required this.subject
  });

  Support copyWith({
    String? name,
    String? email,
    String? subject,
  }) {
    return Support(
      name: name ?? this.name,
      email: email ?? this.email,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'subject': subject,
    };
  }

  factory Support.fromMap(Map<String, dynamic> map) {
    return Support(
      name: map['name'] as String,
      email: map['email'] as String,
      subject: map['subject'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Support.fromJson(String source) => Support.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Support(name: $name, email: $email, subject: $subject)';

  @override
  bool operator ==(covariant Support other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.subject == subject;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ subject.hashCode;
}
