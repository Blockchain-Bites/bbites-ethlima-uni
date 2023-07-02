// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// LLAMADAS INTERCONTRACTOS
// 1 - Definir la interface del contrato a comunicarme
// 2 - Obtener el address del contrato a comunicarme
// 3 - Crea una instancia con la interface y el address

// 1
interface IOperaciones {
    function suma(uint256 a, uint256 b) external view returns (uint256);

    function c() external view returns (uint256);
}

// 2
// Address: 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99
contract Operaciones {
    uint256 public c;

    // public hace: function c() public view returns(uint256){}

    function suma(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
}

contract Operando {
    uint256 a = 100;
    uint256 b = 200;
    // 3
    IOperaciones operacionesContrato =
        IOperaciones(0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99);

    function calcularSuma() public view returns (uint256) {
        // return Operaciones.suma(a, b);
        return operacionesContrato.suma(a, b);
    }

    function calcularSuma2() public view returns (uint256) {
        address opAdd = 0x9D7f74d0C41E726EC95884E0e97Fa6129e3b5E99;
        return IOperaciones(opAdd).suma(a, b);
    }

    function leerC() public view returns (uint256) {
        return operacionesContrato.c();
    }
}
