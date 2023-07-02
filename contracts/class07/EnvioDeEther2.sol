// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// tries

// Dos maneras de enviar Ether (forzosa)
// 1 - usando selfdestruct
// * destruye un smart contract y
// * envia el ether que tenia ese contrato a un address
// 2 - validando
// * especificas un address para que reciba el premio (pago)

contract EnviaEther {
    constructor() payable {}

    function withDrawEtherTransfer(address _account) public {
        // retirar el total de Ether del contrato
        uint256 balanceContrato = address(this).balance;
        // transferir balanceCOntrato a _account
        // 'transfer' que es una propiedad del tipo de dato address
        // 'address' tiene la propiedad o metodo llamado transfer

        // Incorrecto: el address _account va a transferir la cantidad de balanceContrato
        // Correcto: el contrato Ether va a transferir balanceContrato a _account
        payable(_account).transfer(balanceContrato);

        // Con transfer, si la transferencia falla el error se lanza y se
        // interrumpe la ejecucion del metodo
        // No hay manera de controlar el error

        // El presupuesto de gas a gastar es 2300
        // 2300 de gas alcanza para:
        // - lanzar un evento
        // - actualizar una variable
    }

    function withDrawEtherSend(address _account) public {
        uint256 balanceContrato = address(this).balance;
        bool success = payable(_account).send(balanceContrato);
        // success: indica si la transferencia fue exitosa o no
        // si no fue exitosa success === false;
        // si fue exitosa success === true;
        // Con send, si la transferencia falla no se interrumpe el metodo
        // Puedes continuar con otra logica si falla la transferencia
        // El presupuesto de gas a gastar es 2300
        require(success, "La transferencia fallo");
    }

    // Puedes manejar la cantidad de gas a gastar en el contrato donde se ejecuta el receive/fallback
    function withDrawEtherCall(address _account) public {
        uint256 balanceContrato = address(this).balance;
        (bool success, ) = payable(_account).call{
            value: balanceContrato,
            gas: 500000
        }("");
        // error: es la razon por la cual fallo la transferencia
        // error esta codificado
        // para descodificar el error se usa abi.decodePack(tipos de dato)
        require(success, "La transferencia fallo");
    }

    function withDrawEtherCall2(address _account) public {
        uint256 balanceContrato = address(this).balance;
        (bool success, ) = payable(_account).call{
            value: balanceContrato,
            gas: 500000
        }(abi.encodeWithSignature("metodoRecibeEther"));
        require(success, "La transferencia fallo");
    }
}

// 0x406AB5033423Dcb6391Ac9eEEad73294FA82Cfbc
contract RecibeEther {
    function consumirGas() public pure {
        uint256 a = 123;
        for (uint256 i; i < 10; i++) {
            a += a;
        }
    }

    function metodoRecibeEther() public payable {
        // otras operaciones
    }

    receive() external payable {
        consumirGas();
        // EnviaEther(0xd7Ca4e99F7C171B9ea2De80d3363c47009afaC5F).metodoDeEnviaEther();
    }

    fallback() external payable {}
}
