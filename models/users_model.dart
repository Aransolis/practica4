class UsersDAO{
  int? idUsuario;
  String? imagen;
  String? nombre;
  String? correo;
  String? numero;
  String? urlGit;
  
  UsersDAO({this.idUsuario, this.imagen, this.nombre, this.correo, this.numero, this.urlGit});

  factory UsersDAO.fromJson(Map<String, dynamic> mapUser){
    return UsersDAO(
      idUsuario: mapUser['id_Usuario'],
      imagen: mapUser['imagen'],
      nombre: mapUser['nombre'],
      correo: mapUser['correo'],
      numero: mapUser['numero'],
      urlGit: mapUser['urlGit']
    );
  }
}