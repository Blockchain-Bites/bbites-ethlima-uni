// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
INTERFACES
1
- Obligar a que el contrato implemente ciertas functions
- Autoaplicar un estándar
- Reglas autoaplicables

2
- Llamadas intercontratos
*/

// quiero definir una interface con un metodo suma
// function suma(a, b) {return a + b}
// Interface
// - en un interface solo se define las firmas de los metodos (1ra linea)
// - no se define el comportamiento de los metodos
// - el comportamiento (logica) es definida en el contrato que hereda le I
// - Todo metodo en la interface lleva el visibilizador external
interface ISuma {
    function suma(uint256 a, uint256 b) external returns (uint256);
}

// 1 - Reglas autoaplicadas (estándar)
contract Operaciones is ISuma {
    function suma(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
}
