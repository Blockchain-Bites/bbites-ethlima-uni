// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// tries

// Dos maneras de enviar Ether (forzosa)
// 1 - usando selfdestruct
// * destruye un smart contract y
// * envia el ether que tenia ese contrato a un address
// 2 - validando
// * especificas un address para que reciba el premio (pago)

contract Ether {
    uint256 public balanceEther;

    event Receive();
    event Fallback();

    constructor() payable {}

    function getBalance() public view returns (uint256) {
        // this: este contrato
        // address(this): address del contrato
        // .balance: balance de Ether del address
        return address(this).balance;
    }

    // msg.value
    // La cantidade Ether que se está enviando
    receive() external payable {
        balanceEther += msg.value;
        emit Receive();
    }

    fallback() external payable {
        emit Fallback();
    }

    mapping(address => uint256) public _balancesEther;

    function guardarBalanceEther(address _account) public payable {
        _balancesEther[_account] += msg.value;
    }
}
