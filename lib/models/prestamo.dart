class Prestamo {
  final String id;
  final String prestamo;
  final String pago;
  final String fecha;

  Prestamo({this.id = "", this.prestamo = "", this.pago = "", this.fecha = ""});

  factory Prestamo.fromMap(Map<String, dynamic> res) {
    return Prestamo(
        id: res["id"],
        prestamo: res["prestamo"],
        pago: res["pago"],
        fecha: res["fecha"]);
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'prestamo': prestamo, 'pago': pago, 'fecha': fecha};
  }
}
