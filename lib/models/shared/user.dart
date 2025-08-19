class User {
  // Constructor
  User({
    required this.name, 
    required this.profilePicture, 
    required this.email,
    required this.city, 
    required this.birthday, 
    required this.remarks, 
    required this.visitedPlaces, 
    required this.whyUnicab,
    required this.userActive,
    required this.userRole
  });

  // Properties
  final String name;
  final String email;
  
  final String city;
  final String birthday;

  final String remarks;
  final String visitedPlaces;

  final String whyUnicab;
  final String profilePicture;

  final int userActive;
  final int userRole;

  // fromJson Constructor
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['nombre'] ?? '',
      email: json['correo'] ?? '',
      city: json['ciudadResidencia'] ?? '',
      birthday: json['cumpleaños'] ?? '',
      remarks: json['observaciones'] ?? '',
      visitedPlaces: json['lugaresVisitados'] ?? '',
      whyUnicab: json['porqueUnicab'] ?? '',
      profilePicture: json['fotoPerfil'] ?? '', 
      userActive: json['activo'] ?? 0, 
      userRole: json['rol'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'city': city,
    'birthday': birthday,
    'remarks': remarks,
    'visitedPlaces': visitedPlaces,
    'whyUnicab': whyUnicab,
    'profilePicture': profilePicture,
    'userActive': whyUnicab,
    'userRole': profilePicture,
  };
}