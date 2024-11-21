class CantidadDigitosIngresados {
  int cantidadDigitos(int numero) {
    int cantidad = 0;
    while (numero > 0) {
      numero = (numero / 10).floor();
      cantidad++;
    }
    return cantidad;
  }
}