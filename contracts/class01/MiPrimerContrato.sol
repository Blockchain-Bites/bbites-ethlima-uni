// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract MiPrimerContrato {
    // variables llevan el tipo de dato
    string saludo = "Hola desde la UNI!";

    // Getter
    // metodo de lectura - read-only
    // los metodos llevan 'view'
    // el valor de retorno tambien es tipado
    function leerSaludo() public view returns (string memory) {
        return saludo;
    }

    // Setter
    // metodo de escritura
    function guardarSaludo(string memory nuevoSaludo) public {
        saludo = nuevoSaludo;
    }
}
