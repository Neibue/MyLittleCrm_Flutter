class Company {
  String name;
  String siretNumber;

  Company({String name, String siretNumber})
      : this.name = name ?? '',
        this.siretNumber = siretNumber ?? '';

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(name: json['name'], siretNumber: json['siretNumber']);
  }
}
