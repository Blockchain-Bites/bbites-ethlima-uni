// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Register2 {
    string private info;
    uint public countChanges;
    int256 withNegativeNumbers;
    address owner;

    string[] private infos;

    // block.timestamp: cantidad de segundos pasados desde 1970
    uint256 tiempoDePublicacion = block.timestamp;

    constructor() {
        info = "Sol";
        owner = msg.sender;
        infos.push("SOL");
    }

    // Arrays fijos
    // Sintaxis: T[k]
    // T: tipo de dato a usar
    // k: cantidad de elementos

    // ARray de 10 elementos booleans
    // [false, false, ..., false]
    bool[10] _listaBools;

    // ARray de 50 enteros;
    // [0, 0, ..., 0]
    uint256[50] _listaEnteros;

    // Array de 100 addresses;
    // Por default, las 100 posiciones ya fueron definidas por SOlidity
    // 0x00 => address(0)
    // [0x00, 0x00, ..., 0x00]
    address[100] _listaDeAddresses;
    address[100][] _listaDeListaDeAddresses;

    //address[2] _arrayAddresses;
    //_arrayAddresses[1] = miAddress
    // EVM
    // [2][0x00, _arrayAddresses] // una escritura

    //address[] _arrayAddresses;
    // EVM
    // [0][]
    //_arrayAddresses.push(miAddress)
    // EVM
    // [1][miAddress] // 2 escrituras de informacion

    function guardarBools() public {
        // Si mi array es tamaño fijo, solo puedo usar el i para guardar info
        _listaBools[0] = true;
        // No puedo hacer: push, pop
        // _listaBools.push(true);
        _listaBools[1] = true;
        _listaBools[2] = true;
        _listaEnteros[0] = 0;
        _listaEnteros[1] = 1;
        _listaEnteros[2] = 2;
        _listaEnteros[3] = 3;
        _listaEnteros[4] = 4;

        // "remover" un elemento con indice conocido
        // [1,2,3,4]
        delete _listaEnteros[0];
        // X INCORRECTO: [2,3,4]
        // CORRECTO (regresa a su valor default): [0,2,3,4]
    }

    // Array Dinámico:
    // SIntaxis: T[]
    // T: tipo de dato
    // Array dinamico del tipo de  dato address
    address[] _arrayDinAddresses;
    // Array dinamico del tipo de  dato entero
    uint256[] _arrayDinEnteros;

    function guardarInfoArrayDinamico() public {
        // Se puede usar el .push y el .pop
        // .push: añadir un elemento al final de la lista
        // .pop: remover el úlimo elemento de la lista
        // .slice: no hay en solidity
        // .splice: no hay en solidity

        // []
        _arrayDinAddresses.push(msg.sender);
        // [msg.sender1]
        _arrayDinAddresses.push(msg.sender);
        // [msg.sender1, msg.sender2]
        _arrayDinAddresses.push(msg.sender);
        // [msg.sender1, msg.sender2, msg.sender3]

        _arrayDinAddresses.pop();
        // [msg.sender1, msg.sender2]
        _arrayDinAddresses.pop();
        // [msg.sender1]
        _arrayDinAddresses.pop();
        // []
    }

    function getInfo() public view returns (string memory) {
        return info;
    }

    modifier ValidarQueNoEsElOwner() {
        require(owner == msg.sender, "No eres el owner del contrato");
        _;
    }

    modifier ValidarSiCadenaEstaVacia(string memory _info) {
        require(bytes(_info).length > 0, "La cadena esta vacia");
        _;
    }

    event InfoChange(string oldInfo, string newInfo);

    function addInfo(string memory _info) external {
        // Guarda un nuevo elemento en el array (al final)
        infos.push(_info);
    }

    function setInfo(
        uint256 _index,
        string memory _info
    ) external ValidarQueNoEsElOwner ValidarSiCadenaEstaVacia(_info) {
        emit InfoChange(info, _info);
        info = _info;
        ++countChanges;

        // Actualiza un index ya existente
        // que pasas _index > infos.length
        require(_index < infos.length, "Out of bounds");
        infos[_index] = _info;
    }

    // Memoria perm
    // storage: informacion que se guarda de manera permanente

    // Memoria temporal
    // memory: existe mientras se ejecuta el método
    // caldata
    // ix   :       0           1       2           3
    // infos: ["string1", "string2", "string3", "string4", ...]
    // Recuperar informacion desde un ixA hasta in ixB

    function recuperarInfo(
        uint256 ixStart,
        uint256 ixEnd
    ) public view returns (string[] memory) {
        require(ixEnd > ixStart);
        require(ixEnd < infos.length);

        uint256 _lonArrRecuperar = ixEnd - ixStart + 1;
        // Para crear un array en un metodo(temporal), especificas la lon
        // memory _infosAux: _infosAux se guardara en  memoria temporal
        // new string[](_lonArrRecuperar): array de strings de lon _lonArr..
        // Dentro de un método no puedo crear arrays en storage!!!!!
        // No puedo crear arrays dinámicos dentro de un método!!!!!
        string[] memory _infosAux = new string[](_lonArrRecuperar);
        // string[10] memory _infosAux2;

        for (uint256 i = ixStart; i <= ixEnd; ) {
            _infosAux[i - ixStart] = infos[i];

            // unchecked: evitar que verifique el overflow y underflow
            // Ahorrar un poco mas de gas
            unchecked {
                i++;
            }
            return _infosAux;
        }
    }
}
