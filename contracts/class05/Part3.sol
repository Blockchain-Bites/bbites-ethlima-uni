// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Register11 {
    address public owner;
    mapping(address => string) public infos;
    mapping(address => uint) public countChanges;

    // ColorInfo {0, 1, 2}
    enum ColorInfo {
        Undefined,
        Blue,
        Red
    }
    enum Estados {
        Antes,
        Durante,
        Despues
    }

    struct InfoStruct {
        ColorInfo color;
        string info;
        uint256 cantidadDeCambios;
    }
    mapping(address => InfoStruct) _infoEnum;

    function guardarInfo(ColorInfo _color, string memory _info) public {
        _infoEnum[msg.sender] = InfoStruct({
            color: _color,
            info: _info,
            cantidadDeCambios: 1
        });
    }

    constructor() {
        owner = msg.sender;
        infos[msg.sender] = "Sol";

        InfoStruct(ColorInfo.Blue, "Hola", 1);
    }

    event InfoChange(address account, string oldInfo, string newInfo);

    function getInfo() public view returns (string memory) {
        return infos[msg.sender];
    }

    function setInfo(string memory _info) external {
        emit InfoChange(msg.sender, infos[msg.sender], _info);
        infos[msg.sender] = _info;
        countChanges[msg.sender]++;
    }
}
