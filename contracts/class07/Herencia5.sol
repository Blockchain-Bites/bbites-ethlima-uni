// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ContractAImportar} from "./Herencia4.sol";

contract Humano is ContractAImportar {
    string saludo;
    uint256 anio;

    constructor(string memory _saludo, uint256 _anio) {
        anio = _anio;
        saludo = _saludo;
    }
}

contract Hombre is Humano {
    uint256 altura;

    constructor(
        uint256 _altura,
        string memory _saludo,
        uint256 _anio
    ) Humano(_saludo, _anio) {
        altura = _altura;
    }
}

contract Marcos is Humano, Hombre {
    constructor() Hombre(200, "Hola, soy Humano", 2023) {}
}

contract A {
    uint256 a;

    constructor(uint256 _a) {
        a = _a;
    }
}

contract B {
    uint256 b;

    constructor(uint256 _b) {
        b = _b;
    }
}

contract C is A, B {
    constructor() A(3) B(3) {}
}
