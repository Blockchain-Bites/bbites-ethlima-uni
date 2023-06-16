// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// El nombre del arcivho no tiene que coincidir con el nombre del contrato
// Es buena práctia hacer que coincidan: legibilidad
contract MiPrimerContrato2 {
    // uint: unsigned integer (entero sin signo)
    // rango de uint256: [0 - 2^256 - 1)
    // uint16
    // uint32
    // uint64
    // uint128
    // Todas los uintX ocupan el mismo espacio de memorio en el SC
    uint256 edad = 234;

    // Solidity ha creado el getter de manera automatc.
    uint256 public anio = 2023;

    // Valores Default
    // Solidity define valores por defecto dep.
    // del tipo de dato que estes utilziando
    // En solidity no existe undefined ni null
    bool public esDeNoche = true;
    uint256 public cantidadDeAl = 1252;

    // getter
    // Es un método de lectura
    // read-only
    // no guarda/altera informacion
    // Visibilizadores del metodo:
    // view se usa en metodos de solo lectura
    // public: sera usado por usuarios externos
    // private/internal: no será usado por usuario externos
    // no existe visiblizador por defecto: arroja un error
    function obtenerEdad() public view returns (uint256) {
        return edad;
    }

    // setter
    // método que escribe, que guarda info
    function cambiarEdad(uint256 nuevaEdad) public {
        edad = nuevaEdad;
    }
}
