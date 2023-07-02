// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Humano {
    string saludo;
    uint256 anio;

    constructor(string memory _saludo, uint256 _anio) {
        anio = _anio;
        saludo = _saludo;
    }
}

// Literal
// Sabes los valores a usar en el constructor a priori
contract Hombre is Humano("Hola, soy Humano", 2023) {

}

// Tipo Modifer
// Sabes los valores a usar en el constructor a priori
contract Hombre2 is Humano {
    constructor() Humano("Hola, soy Humano", 2023) {}
}

// Más dinámico
contract Hombre3 is Humano {
    constructor(string memory _saludo, uint256 _anio) Humano(_saludo, _anio) {}

    modifier modiferConArgs(uint256 a, uint256 b) {
        _;
    }

    function suma(
        uint256 a,
        uint256 b,
        uint256 c,
        uint256 d
    ) public modiferConArgs(c, d) {
        // a,b,c y d está disponisbles en el cuerpo
        // a,b,c y d están disponisbles para los modifiers del metodo
    }
}

contract ContractAImportar {}
