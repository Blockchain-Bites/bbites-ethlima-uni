// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LeeMarrerosToken is ERC20, Ownable {
    constructor() ERC20("Lee Marreros Token", "LMRRTKN") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

/**
 DECIMALS:
 
 Unidad mas pequeña: 1 sol
- yo quiero enviar 0.5 sol: no se puede

Unidad mas pequeña: 10 Indis === 1 sol
- yo quiero enviar 0.5 sol: 5 Indis
- Mi moneda tiene un decimal
- Mi moneda tiene hasta 10 partes
- yo quiero enviar 1/10 sol: 1 Indis
- Yo quiero enviar 1/100 sol: no se puede

Unidad mas pequeña: 100 Lunas === 1 sol
- Yo quiero enviar 1/100 sol: 1 Luna
- Quiero enviar 1 sol: tengo que enviar 100 Lunas
- 1 sol = 10ˆ2 Lunas (2 decimales)

Ether
Unidad mas pequeña es el Wei
1 Eth = 1 * 10ˆ18 Wei (18 decimals)
1 Wei = 1 10^-18 Eth

EN solidity no existe el punto flotante (decimals)
En solidity solo hay division de enteros
3 / 5 = 0
5 / 3 = 1

 */
