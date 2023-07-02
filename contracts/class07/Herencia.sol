// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
    C3 linearization: es un algoritmo para heredar metodos
*/
// Contrato más base (está más arriba en la cadena)
contract A {
    // Lo que se hereda (lo que se transmite por herencia):
    // - metodos
    // - modifiers
    // - variables de estado
    // - eventos
    // ¿Qué no se hereda?
    // Todo lo que se haya definido como 'private'
    // * Los metodos external tambien se heredan
    function metodoExternal() external {} // Sí se hereda

    function metodoPrivate() private {} // No se heredaría
}

// (En relacion a A) B es el contrato más derivado
contract B is A {

}

// La herencia se da desde el contrato + base hasta el + derivado
// Más base -> màs derivado (orden para heredar)
contract C is A, B {

}

contract D is A, B, C {}

// no hay cadena
contract E {

}

contract F {}

contract G is E, F {

} // F y E no dependen (uno no hereda del otro)
