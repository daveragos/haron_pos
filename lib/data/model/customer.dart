enum Gender { male, female }

class Customer {
  final String name;
  final String phone;
  final String? address;
  final Gender gender;

  Customer({
    required this.name,
    required this.phone,
    required this.gender,
    this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      gender: Gender.values.firstWhere((e) => e.toString() == 'Gender.${json['gender']}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'gender': gender.toString().split('.').last,
    };
  }
}
