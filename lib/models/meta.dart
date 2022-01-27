class Meta {
  final int? id;
  final String meta;
  final String ahorro;
  final String fecha;

  Meta({this.id, this.meta = "", this.ahorro = "", this.fecha = ""});

  factory Meta.fromMap(Map<String, dynamic> res) {
    return Meta(
        id: res["id"],
        meta: res["meta"],
        ahorro: res["ahorro"],
        fecha: res["fecha"]);
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'meta': meta, 'ahorro': ahorro, 'fecha': fecha};
  }
}
