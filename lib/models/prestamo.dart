class Prestamo {
  final String id;
  final String prestamo;
  final String pago;
  final String fecha;
  final String interes;

  Prestamo(
      {this.id = "",
      this.prestamo = "",
      this.pago = "",
      this.fecha = "",
      this.interes= ""});

  factory Prestamo.fromMap(Map<String, dynamic> res) {
    return Prestamo(
        id: res["id"],
        prestamo: res["prestamo"],
        pago: res["pago"],
        fecha: res["fecha"],
        interes: res['interes']);
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'prestamo': prestamo,
      'pago': pago,
      'fecha': fecha,
      'interes': interes
    };
  }
}
