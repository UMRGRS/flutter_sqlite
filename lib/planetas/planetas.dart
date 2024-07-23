class Planetas{
  int? ID;
  String? nombre;
  double? AU;
  double? radius;

  Planetas(this.ID, this.nombre, this.AU, this.radius);

  Planetas.Mapa(Map<String, dynamic> map){
    ID = map["id"];
    nombre = map["nombre"];
    AU = map["AU"];
    radius = map["radius"];
  }

  Map<String, dynamic> toMap(){
    return {
      "id": ID,
      "nombre": nombre,
      "AU": AU,
      "radius": radius
    };
  }
}