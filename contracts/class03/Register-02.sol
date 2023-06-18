// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Register2 {
    string private info;
    uint public countChanges; // = 0; (redundante)
    int256 withNegativeNumbers;
    address owner;

    constructor() {
        info = "Sol";
        owner = msg.sender;
    }

    function getInfo() public view returns (string memory) {
        return info;
    }

    // MODIFIER
    // Sirve para extender la funcionalidad de un método
    // Se pueden hacer validaciones (multiples) antes de que se ejecute el metodo
    // EL modifier tiene el control de dictar la ejecucion del cuerpo del metodo
    // El modifier tiende a ser atomica en la validacion (checkings)
    modifier ValidarQueNoEsElOwner() {
        // Require
        require(owner == msg.sender, "No eres el owner del contrato");
        // Revert
        // require(owner == msg.sender, "No eres el owner del contrato");
        // if (owner != msg.sender) revert("No eres el owner del contrato");
        // // Revert con error personalizado
        // // Nuevo estandar - menos costos
        // if (owner != msg.sender) revert NoEsElOwner();

        //_; => wildcard fusion (comodín fusion)
        // Indica se debe ejecutar el metodo
        _;
    }

    // error NoEsElOwner();
    // Este error se dispara en revert NoEsElOwner();

    modifier ValidarSiCadenaEstaVacia(string memory _info) {
        require(bytes(_info).length > 0, "La cadena esta vacia");
        _;
    }

    // Eventos
    // - Es una manera de propagar informacion del smart contract hacia afuera
    // - Otros agentes (backned, frontendt) pueden suscribirse para escuchar los eventos
    // - Todos los eventos se guardan en el blockchain
    // - Se usa como storage barato para guardar informacion
    // - Usando JS pueden hacer queries (como si fuera SQL) a los eventos pasados
    // - Otros contratos inteligentes no pueden escuchar eventos
    event InfoChange(string oldInfo, string newInfo);

    function setInfo(
        string memory _info
    ) external ValidarQueNoEsElOwner ValidarSiCadenaEstaVacia(_info) {
        emit InfoChange(info, _info);
        info = _info;
        ++countChanges; // <= este es el menos costos
    }

    function setInfo2() public ValidarQueNoEsElOwner {}
    // function setInfo3() public  ValidarSiCadenaEstaVacia {}
}
