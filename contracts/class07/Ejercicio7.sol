// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * SwapEtherAndTokens
 *
 * Vamos a crear un contrato que nos permita hacer un swap de ether a tokens.
 * Dicho contrato se llamará SwapEtherAndTokens. Este contrato puede ser
 * usado para comprar los tokens de un proyecto.
 * En principio, cuando token es creado, este token debe ser distribuido.
 * Una manera de hacerlo es através de un contrato donde se pueda comprar el token
 * con otra moneda más conocida, como Ether.
 *
 * Objetivos del contrato SwapEtherAndTokens:
 * 1 - Cuando un usuario llame swapEtherAndTokens, el contrato debe recibir
 *     Ether y enviar tokens al usuario.
 * 2 - Cuando su método receive() sea disparado, el contrato debe recibir Ether
 *     y enviar tokens al usuario.
 * 3 - Tiene un mecanismo para retirar el Ether del contrato usando 'withdrawEther'
 *
 * Nota: el ratio está predefinido en 2500 tokens por 1 Ether para este ejercicio
 *
 *
 * ExecuteOperation
 *
 * El usuario que hará uso del contrato SwapEtherAndTokens será otro contrato
 * llamado ExecuteOperation. Este contrato tiene dos métodos:
 *
 * 1 - function executeWithCall() public:
 *      * Se envia Ether al contrato SwapEtherAndTokens
 *      * Se llama al método swapEtherAndTokens del contrato SwapEtherAndTokens
 * 2 - function executeReceive() public
 *      * Se envia Ether al contrato SwapEtherAndTokens
 *      * Se dispara el método receive() del contrato SwapEtherAndTokens
 *
 *
 *
 * correr tests:
 * npx hardhat test test/EjercicioSemana7.js
 */

interface IToken {
    // define aqui los metodos que usaras de este contrato
}

contract TokenEjercicio7 is ERC20 {
    constructor() ERC20("TokenEjercicio7", "TKN") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract SwapEtherAndTokens {
    // 1 Eth = 2500 tokens
    uint256 ratio = 2500;

    // Crea una instancia del token usando una interfaz del token IToken
    // IToken token;

    constructor(address tokenAddress) {
        // usa el tokenAddress que es pasado en el constructor para crear una instancia del token
        // token = ...;
    }

    // Crea el metodo swapEtherAndTokens
    // Debe ser public y payable
    // En su interior calcular cuantos tokens acuñar
    // El cálculo es cantidad de Ether enviado * ratio
    // Se llama 'mint' del contrato token
    // function swapEtherAndTokens()...

    // Crea el metodo receive
    // Debe ser external y payable
    // Cuando receive es disparado, debe hacer lo mismo que swapEtherAndTokens
    // receive()

    // Crea el metodo withdrawEther(address payable _to)
    // Debe ser public
    // Debe transferir el total de balance del contrato al address _to
    // function withdrawEther(address payable _to)...
}

contract ExecuteOperation {
    // Guarda el address del contrato SwapEtherAndTokens
    // Esta address será usada para ejecutar llamadas 'call'
    address swapAddress;

    // Convierte el constructor en payable para que pueda recibir Ether
    // al mismo tiempo que es creado
    // 1 Ether es depositado al momento de su creación para simular
    // la posesión de fondos cuando se corren los tests
    constructor(address _swapAddress) {
        swapAddress = _swapAddress;
    }

    // Crea el metodo executeWithCall
    // Debe ser public
    // Debe hacer una llamada 'call' al contrato SwapEtherAndTokens
    // El presupuesto de gas a gastar es 500000
    // El valor a enviar es el balance del contrato
    // La firma del metodo a llamar es 'swapEtherAndTokens()'
    // function executeWithCall()...

    // Crea el metodo executeReceive
    // Debe ser public
    // Debe enviar Ether al contrato SwapEtherAndTokens
    // El valor a enviar es el balance del contrato
    // El presupuesto de gas a gastar es 500000
    // Con este metodo se planea disparar el metodo receive del contrato SwapEtherAndTokens
    // function executeReceive()...
}
