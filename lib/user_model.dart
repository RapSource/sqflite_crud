class User {
  int? idUser;
  String name;
  String email;
  String noHp;
  String tanggalLahir;
  String jenisKelamin;

  User(
      {
      this.idUser,
      required this.name,
      required this.email,
      required this.noHp,
      required this.tanggalLahir,
      required this.jenisKelamin});

  factory User.fromJson(Map<String, dynamic> json) => User(
      idUser: json['idUser'],
      name: json['name'],
      email: json['email'],
      noHp: json['noHp'],
      tanggalLahir: json['tanggalLahir'],
      jenisKelamin: json['jenisKelamin']);

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'email': email,
        'noHp': noHp,
        'tanggalLahir': tanggalLahir,
        'jenisKelamin': jenisKelamin
      };
}
