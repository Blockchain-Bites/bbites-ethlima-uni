// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Register {
    // Visibilizador
    // No se hereda
    // SOlo se usa dentro del contrato
    string private info;

    // entero / integer
    // uint - u unsigned, int integer
    // uint === uint256, rango [0, 2^256 - 1]
    // uint128 = rango [0, 2^128 - 1]
    // uint64 = rango [0, 2^64 - 1]
    // uint32 = rango [0, 2^32 - 1]
    // uint16 = rango [0, 2^16 - 1]
    // uint8 = rango [0, 2^8 - 1]
    // Memory de cualquier rango de entero es el mismo (32 bytes == 256 bits)
    uint public countChanges; // = 0; (redundante)

    // int - sí incluye números negativos
    int256 withNegativeNumbers;

    // Se estila llamar al que despliega el contrato owner/admin
    address owner;

    // Uno de sus proposito es inyectar info del mundo de afuera al SC
    // Inicializa variables
    // Se ejecuta una sola vez durante la vida del smart contract
    constructor() {
        info = "Sol";
        // podemos capturar la billetera de quien publica el smart contract
        // msg.sender es una variable global
        // - estan definidas por SOlidity
        owner = msg.sender;
    }

    // getter
    function getInfo() public view returns (string memory) {
        return info;
    }

    // setter
    // external
    // - puede ser usado desde afuera
    // - no se puede usar dentro del smart contract
    function setInfo(string memory _info) external {
        // owner
        // msg.sender <= aqui representa a quien llama al metodo
        // Manera ingenua de proteger o de dar privilegio a una
        // if (owner != msg.sender) return;

        // Si hay un require que falla, todos los cambios se revierten
        // Atomicidad de la tx
        // - o todo se guarda o nada se guarda
        // - o todo se ejecuta o nada se ejecuta
        countChanges += 10;

        // Permite hacer validaciones
        // Si no se pasa la validacion se interrumpe el metodo en esa linea
        // Se cobra el gas usado hasta esa linea
        // Se revierten todos los cambios
        // require(defines validacion logica, "El mensaje en caso de error");
        require(owner == msg.sender, "No eres el owner del contrato");
        // require(si _info esta vacio => false, "No ingresar una cadena vacia");
        // si bytes(_info).length  ==0, la cadena esta vacia
        // si bytes(_info).length  > 0, la cadena no esta vacia
        require(bytes(_info).length > 0, "La cadena esta vacia");

        info = _info;
        // countChanges = countChanges + 1;
        // countChanges +=  1;
        // countChanges++;
        ++countChanges; // <= este es el menos costos
    }
}
