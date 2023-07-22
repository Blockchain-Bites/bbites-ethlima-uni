// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Victim {
    constructor() payable {}

    mapping(address => uint256) public balances;

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0);
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success);
        balances[msg.sender] = 0;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
}

contract NoVictim {}

interface IVictim {
    function deposit() external payable;

    function withdraw() external;
}

contract Attacker {
    IVictim victim;

    constructor(address _victimAddress) payable {
        victim = IVictim(_victimAddress);
    }
}

contract Attacker2 {}
