// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// El nombre del archivo se sugiere quew lleve el mismo nombre que el contrato: legibilidad
contract LeeMarreros {
    // Solidity designa valores por default de manera automática a todas las variables
    // El valor de default depende del tipo de dato que estás usando:
    // uint256  => valor default es 0
    // string  => valor default es ""
    // bool  => valor default es false
    // En soliidity no existe el undefined ni null, como si lo hay en javascript

    // 'private':
    // - significa que esta variable solo puede ser usada dentro del smart contract
    // - es una variable que no se heredará y ningún otro sc lo usará

    // cuando no defined una visiblidad, se considera 'internal'
    // 'internal':
    // - la variable puede ser usada dentro de este smart contract
    // - la variable se puede heredar y ser usada por otros smart contracts

    // 'public'
    // - puedes ser usada dentro de este contrato
    // - puede ser herdado por otros contratos y usado
    // - expone a la variable/metodo a ser usado por usuario externos
    // - si se trata de una variable, crea autom[aticamente un getter para esa variable
    string private fullName;

    // el tipo de dato address se utiliza para guardar billteras
    address public owner;

    // Inicializar variables
    // SIreve para inyectar información en el smart contract (desde afuera)
    // El constructor se ejecuta una sola vez: cuando el contrato se publica
    // El constructor se ejecuta también cuando se crea una instancia de un contrato
    // En el constructor puedo identificar a la billetera que está publicando el contrato
    // Para identificar quien lo publica utilizo una variable global llamada msg.sender
    // es global porque solidity lo brinda y no hay necesidad de definirlo.
    constructor(string memory _lastName) {
        fullName = string.concat("Lee", " ", _lastName);

        // GUardo a la billtera que publica el SC en la variable owner;
        owner = msg.sender;
        // Falla aqui
    }

    // Definiendo un getter para leer la variable fullName;
    // 'memory': acompaña los tipos de dato dinámico en solidity
    // arrays, string, bytes son ejemplos de tipo de dato dinámico
    // 'memory' se especifica únicamente en los parámetros, returns y implementación del método
    // 'memory' instruye para que se guarde la información de manera temporal
    function getName() public view returns (string memory) {
        //
        //
        //
        //
        // falla la ejecucion del metodo/ se interrumpe
        return fullName;
    }

    // TIPOS DE CUENTA (del tipo dato 'address')
    // 1. EOA (Externally owned account)
    // 2. SCA (smart contract account)

    // EOA
    // la billetera (address) que tenemos en metamask
    // no contiene código
    // sí tiene una llave privada que nos sirve para firmar transacciones

    // ScA
    // la billetera (address) de nuestro smart contract
    // sí contiene código
    // un contrato inteligente solo puede ejecutar los métodos definidos en ella
    // no existe llave privada

    // XIAoMI 12
    // lima2022
}
