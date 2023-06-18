// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// One info per address = mapping of string
// You can only modify your info, no whitelist
// countChanges per address

contract Register11 {
    address public owner;
    mapping(address => string) public infos;
    mapping(address => uint) public countChanges;

    // mappings y array
    // key => value
    // tipo de dato value podria ser array?
    // como definia un array de strings de tamaño dinámico?
    // T[]
    // string[]
    mapping(address => string[]) public infoArray;

    /** mapping
            key             |               value
            0x01            |           [string1, string2, string3]
            0x02            |           [string1, string2, string3]
            ..
    */

    // Whitelist
    // - contratos airdrop
    // - otorga privilegios de acceso, de uso
    // - Es una manera restringir
    // - Pones las addresses que tendrán un privilegio en específico
    // - Sirve para hacer validaciones

    constructor() {
        owner = msg.sender;
        infos[msg.sender] = "Sol";
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
        _; // wildcard
    }

    mapping(address billetera => bool acceso) _whitelist;

    function setInfo(string memory _info) external onlyWhitelist {
        emit InfoChange(msg.sender, infos[msg.sender], _info);
        infos[msg.sender] = _info;
        countChanges[msg.sender]++;
    }

    // setter de _whitelist
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

    // Merkle tree
    // Si tiens mil address => hash. Guardas el hash en el smart contract
    // verificaSiEstaEnHash() {
    // msg.sender: la persona que quiere participar
    // hash: usado para validar
    // bool access = verifyInHash(msg.sender, hash);
    // require(access);
    //}

    // mapping(address billetera => string[]) public infoArray;
    // Setter de infoArray
    // En solidity a todo tipo de dato dinámico especificas el nivel de memoria
    // string, arrays, bytes son tipos de dato dinamico
    // 3 tipos de memoria: memory, storage, calldata
    // memory:
    //  - temporal, mientras se ejecuta el método.
    //  - se puede modificar la variable dentro del metodo
    //  - se asginan mas opcods para que dicha variable se pueda modificar
    // calldata:
    //  - temporal, mientras se ejecuta el método.
    //  - no se puede modificar la variable dentro del metodo
    //  - calldata es mas económico
    //  - se podria pensar a la variable como una constante

    // setter de mapping(address billetera => string[]) public infoArray;
    // string[] es tipo de array dinamico: si tiene push
    // string[3] es un tiop de array fijo: no tiene push
    function setInfoArray(address _account, string memory _cadena) public {
        infoArray[_account].push(_cadena);
        countChanges[msg.sender]++;
    }

    // getter
    // mapping(address billetera => string[])
    // Quiero retornar todo lo que esta en value
    function leerInfoArray(
        address _account
    ) public view returns (string[] memory) {
        return infoArray[_account];
    }

    function leerTuInfo() public view returns (string[] memory) {
        return infoArray[msg.sender];
    }

    // ERC721Enumerable
    // mapping(address => uint256[]) _listaDeNftsEnPosecion;
    /**
                key             |               value
                0x01            |           [tokenID1, tokenID0, tokenID2]
    */
}
