// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Humano {
    function saludoHumano() public pure returns (string memory) {
        return "Hola, soy Humano";
    }
}

// 'super':
// con super accedemos a un metodo del papa directamente
// contrastar cuando hacemos sobreescritura de un metodo el hijo
contract Hombre is Humano {
    function bienvenidaDeHumano() public pure returns (string memory) {
        return super.saludoHumano();
    }
}

// Multiple herencia
// En el caso de multiple herencia, el super comienza su busqueda
// en el contrato más derivado hacia el contrato más base
// más derivado => más base
contract Marcos is Humano, Hombre {

}
