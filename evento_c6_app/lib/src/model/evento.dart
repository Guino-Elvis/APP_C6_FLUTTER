class EventoModel {
  int? id;
  String? userId;
  String? nombre;
  String? fecha_inicio;
  String? fecha_fin;
  String? foto;



  EventoModel(
      {this.id,
      this.userId,
      this.nombre,
      this.fecha_inicio,
      this.fecha_fin,
      this.foto,

      });

  EventoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    nombre = json['nombre'];
    fecha_inicio = json['fecha_inicio'];
    fecha_fin = json['fecha_fin'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['nombre'] = this.nombre;
    data['fecha_inicio'] = this.fecha_inicio;
    data['fecha_fin'] = this.fecha_fin;
    data['foto'] = this.foto;
    return data;
  }
}