// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/**
 * Ejercicio Semana 4
 *
 * Vamos a crear un contrato que se comporte como un cajero automático o ATM.
 * Mediente este contrato, el usuario puede depositar y retirar fondos.
 * Así también el usuario puede transferir fondos a otro usuario.
 *
 * Tendrá las siguientes características:
 *  - Permite depositar fondos en el contrato mediante el método 'depositar'.
 *  - Permite retirar fondos del contrato mediante el método 'retirar'.
 *  - Permite transferir fondos a otro usuario mediante el método 'transferir'.
 *  - Permite consultar el saldo del usuario. Hacer la estructura de datos 'public'
 *  - Permite consultar el saldo del ATM. Hacer la variable 'public'
 *  - modifier de pausa: verifica si el boolean 'pausado' es true o false
 *  - modifier de admin: verifica que el msg.sender sea el admin
 *  - Permite cambiar el boolean 'pausado' mediante el método 'cambiarPausado' y verifica que solo es llamado por el admin
 *
 * Notas:
 *  - para guardar y actualizar los balances de un usuario, se utilizará un diccionario
 *  - el modifier protector usa un booleano para saber si está activo o no
 *  - este booleano solo puede ser modificado por una cuenta admin definida previamente
 *
 * Testing: Ejecutar el siguiente comando:
 * -  npx hardhat test test/EjercicioSemana4.js
 */

contract EjercicioSemana4Sol {
    // no cambiar
    address public admin = 0x08Fb288FcC281969A0BBE6773857F99360f2Ca06;
    bool public pausado;

    modifier soloAdmin() {
        require(
            msg.sender == admin,
            "Solo el admin puede ejecutar esta funcion"
        );
        _;
    }

    modifier cuandoNoPausado() {
        require(!pausado, "El contrato esta pausado");
        _;
    }

    uint256 public balanceTotal;
    mapping(address usuario => uint256 balance) public balances;

    event Deposit(address indexed _from, uint256 _value);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Withdraw(address indexed _to, uint256 _value);

    error SaldoInsuficiente();

    function depositar(uint256 _cantidad) public {
        balances[msg.sender] += _cantidad;
        balanceTotal += _cantidad;

        emit Deposit(msg.sender, _cantidad);
    }

    function retirar(uint256 _cantidad) public cuandoNoPausado {
        require(balances[msg.sender] >= _cantidad, "Saldo insuficiente");
        balances[msg.sender] -= _cantidad;
        balanceTotal -= _cantidad;

        emit Withdraw(msg.sender, _cantidad);
    }

    function transferir(address _destinatario, uint256 _cantidad) public {
        if (balances[msg.sender] < _cantidad) revert SaldoInsuficiente();
        balances[msg.sender] -= _cantidad;
        balances[_destinatario] += _cantidad;

        emit Transfer(msg.sender, _destinatario, _cantidad);
    }

    function cambiarPausado() public soloAdmin {
        pausado = !pausado;
    }
}
