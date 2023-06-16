// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

contract Mappings {
    /**
     * Digamos que deseo guardar en una tabla
     * el saludo de cada persona que me visite.
     *
     * La tabla luce como la siguiente:
     *
     *       Nombre (llave/key)      |    Saludo (valor/value)
     * -----------------------------|---------------------------
     * 1. Juan                      | Hola, soy Juan
     * 2. Maria                     | Hola, soy Maria
     * 3. Jose                      | Hola, soy Jose
     * 4. Carlos                    | Hola, soy Carlos
     * 5. Alicia                    | Hola, soy Alicia
     */
    // Javascript
    // var obj = {} // es una especie de tabla
    // obj["Juan"] = "Hola, soy Juan"; // primera fila
    // obj["Maria"] = "Hola, soy Maria"; // primera fila
    // obj[llave/Key] = (valor asociado a esa llave/key)
    // Si quiero leer informacion: le paso el key
    // obj["Carlos"]  // Hola, soy Carlos
    // Solidity
    // mapping _listaDeSaludosPorNombre; (key: nombre, value: saludo)
    // mapping(string => string) _listaDeSaludosPorNombre;
    mapping(string nombre => string saludo) public _listaDeSaludosPorNombre;

    // Estructura de datos mas usadas en solidity
    // Es como guardar info en un tabla

    function guardarInfoTable(
        string memory _name,
        string memory _greeting
    ) public {
        // _name: key
        // _greeting: value
        _listaDeSaludosPorNombre[_name] = _greeting;
    }

    function leerInfoDeTable(
        string memory _name
    ) public view returns (string memory) {
        return _listaDeSaludosPorNombre[_name];
    }

    // Tipos de datos a usar
    // En las llaves hay restricciones (no se usa struct, mapping, enums)
    // En los valores no hay restricciones (todo tipo de dato)
    mapping(string => bool) _deStringABoolean;
    mapping(address => uint256) _deAddressAEntero;
    mapping(address => mapping(address => string)) _deAddressAMappingDeAddressAString;

    // Se puede iterar sobre un mapping?
    // - No se puede iterar en un mapping
    // - Solidity on sabe qué valores fueron inicializados
    // - No tiene longitud
    mapping(string => bool) _deStringABoolPublic;
    mapping(address => uint256) public _deAddressAEnterosPub;
    // address[] _keys;
    // mapping(address _key => uint256 _indiceEnKeysArray) _indices;
    // _keys.push(msg.sender)

    //
}
