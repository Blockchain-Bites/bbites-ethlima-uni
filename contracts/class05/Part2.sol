// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Register11 {
    address public owner;
    mapping(address => string) public infos;
    mapping(address => uint) public countChanges;
    mapping(address => string[]) public infoArray;

    // Structs
    // - Es una manera de agrupar diferentes de tipos de variables en un sola
    // - Recuperar (leer) informacion de un struct es mas economico que
    //      leer informacion de las variables por separado
    // - El usuario es capaz de crear datos complejos (definidos por el propio usuario)
    // - CUando se inicializa un struct, se tiene que definir todos sus integrantes
    struct InfoCambios {
        address account;
        string info;
        uint256 cantidadDeCambios;
    }
    InfoCambios[] _infoStructs; // <= array dinamico. puedo usar .push
    mapping(address => InfoCambios) _infoMappings;
    /**
                     (key)          |             (value)
                    address         |           InfoCambios
                    0x001           |           {account, info, qDeCambios}
                    0x002           |           {account, info, qDeCambios}
                        ...
                    0x100           |           {account, info, qDeCambios}
    */
    // mapping(bool => InfoCambios)
    /**
        Mapping de dos filas
                key
                true                |
                false               |
    */
    mapping(string => InfoCambios) public _cadenaToStruct;

    // Hash table: key - value
    // ¿Como se encuentra la posicion del key en la tabla?
    // Hago un hash del key=> posicion en la table (entero)
    // hash(key) = 5
    // hash("un string X") => 6
    //  pos 1      |           |           |
    //  pos 2      |           |           |
    //  pos 3      |           |           |
    //  pos 4      |           |           |
    //  pos 5      |  key      |  value    |
    //  pos 6      |           |   InfoCambios en Zero |

    constructor() {
        owner = msg.sender;
        infos[msg.sender] = "Sol";

        // Definiendo un struct
        // Sucinta
        _infoStructs.push(InfoCambios(msg.sender, "Soy el owner", 1));
        InfoCambios memory _infoCambios = InfoCambios(
            msg.sender,
            "Soy el owner",
            1
        );
        _infoCambios.cantidadDeCambios = 2;
        // <= Estoy guardando en storage el struct que antes en memory
        _infoStructs.push(_infoCambios);
        // Legible
        _infoStructs.push(
            InfoCambios({
                info: "Soy el owner",
                account: msg.sender,
                cantidadDeCambios: 1
            })
        );
    }

    event InfoChange(address account, string oldInfo, string newInfo);

    function getInfo() public view returns (string memory) {
        return infos[msg.sender];
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "No eres el owner");
        _;
    }

    modifier onlyWhitelist() {
        require(_whitelist[msg.sender], "No estas en whitelist");
        _;
    }

    mapping(address billetera => bool acceso) _whitelist;

    function setInfo(string memory _info) external onlyWhitelist {
        emit InfoChange(msg.sender, infos[msg.sender], _info);
        infos[msg.sender] = _info;
        countChanges[msg.sender]++;
    }

    function guardarEnWhitelist(address _whitelistMember) public onlyOwner {
        _whitelist[_whitelistMember] = true;
    }

    function removerDeWhitelist(address _whitelistMember) public onlyOwner {
        _whitelist[_whitelistMember] = false;
    }

    function modificarWhitelist(
        address _member,
        bool _acceso
    ) public onlyOwner {
        _whitelist[_member] = _acceso;
    }

    function setInfoArray(address _account, string memory _cadena) public {
        infoArray[_account].push(_cadena);
        countChanges[msg.sender]++;
    }

    function leerInfoArray(
        address _account
    ) public view returns (string[] memory) {
        return infoArray[_account];
    }

    function leerTuInfo() public view returns (string[] memory) {
        return infoArray[msg.sender];
    }
}
