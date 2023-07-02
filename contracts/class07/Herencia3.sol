// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
SOBREESCRITURA DE METODOS EN HERENCIA
virtual y el override
virtual: marca a un metodo para que se pueda sobreescribir
override: marca al metodo que sobreescribe a un metodo virtual
*/
contract Humano {
    function saludo() public pure virtual returns (string memory) {
        return "Hola, saludo desde Humano";
    }
}

contract Hombre is Humano {
    function saludo() public pure virtual override returns (string memory) {
        return "Hola, saludo desde Hombre";
    }

    function metodoDePapa() public pure returns (string memory) {
        return super.saludo();
    }
}

contract Marcos is Humano, Hombre {
    function saludo()
        public
        pure
        override(Humano, Hombre)
        returns (string memory)
    {
        return "Hola, saludo desde Marco";
    }
}
