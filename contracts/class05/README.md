# BLOCKCHAIN BITES - ETHEREUM LIMA - UNI

WORKSHOP DE PROGRAMACIÓN BLOCKCHAIN

## Ponente

Lee Marreros - [Linkedin](https://www.linkedin.com/in/lee-marreros/) - [Twitter](https://twitter.com/LeeMarreros)

## ¡Síguenos! No te pierdas nigún evento

[Discord](https://discord.gg/7hJBfgfpvs)

[LinkedIn](https://www.linkedin.com/company/blockchain-bites-es/)

[MeetUp](https://www.meetup.com/blockchain-bites)

[Twitter](https://twitter.com/bbitesschool)

## Ejercicios semana 5

### Objetivo: Interactuando con una criptomoneda (ERC20)

## Leer prerrequisito

### Descripción

En Solidity rige la división de enteros y no es posible usar el punto flotante para realizar operaciones. Es por ello que para representar décimas, centésimas o diezmilésimas, se usan los "decimales".

Los "decimales" son la cantidad de ceros que se añaden a la unidad para poder expresar partes mucho más pequeñas que la unidad misma. Veamos la siguiente tabla para comprender como, por ejemplo, el `Ether` puede tener múltiples maneras de expresarse.

| Value (in wei)                    | Ex    | Common name | SI name               |
| --------------------------------- | ----- | ----------- | --------------------- |
| 1                                 | 1     | wei         | Wei                   |
| 1,000                             | 10^3  | Babbage     | Kilowei or femtoether |
| 1,000,000                         | 10^6  | Lovelace    | Megawei or picoether  |
| 1,000,000,000                     | 10^9  | Shannon     | Gigawei or nanoether  |
| 1,000,000,000,000                 | 10^12 | Szabo       | Microether or micro   |
| 1,000,000,000,000,000             | 10^15 | Finney      | Milliether or milli   |
| 1,000,000,000,000,000,000         | 10^18 | *Ether*     | *Ether*               |
| 1,000,000,000,000,000,000,000     | 10^21 | Grand       | Kiloether             |
| 1,000,000,000,000,000,000,000,000 | 10^24 |             | Megaether             |

Vamos a partir del hecho que la única unidad usada dentro del Blockchain es el Wei. De modo tal que cualquier envío de Ether, sin importar la cantidad, se hace en realidad en su equivalente en Wei.

Es decir, para poder enviar `0.001 Ether` (un diezmilésimo de Ether), se envía en realidad `10^15 wei`, o también denominado  `1 Finney`. Y así se puede dividir `1 Ether` en unidades cada vez más pequeñas.

La unidad más pequeña a ser enviada es `1 wei`, que es representado por `10^-18 Ether`. Esta misma lógica se utilizará para crear unidades divisibles cuando se creen criptomonedas.

### Cantidad de `decimals`

En la creación de una criptomoneda se define la cantidad de unidades divisibles que ésta va a llevar. Dicha cantidad, también llamada `decimals`, indica a su vez la mínima unidad disponible de la criptomoneda.

Si una criptomoneda lleva dieciocho (18) decimales, se diría que su mínima unidad divisible sería `1^-18`. O lo que es lo mismo decir, para enviar un token, se tendría que enviar en realidad `10^18` de la más pequeña unidad divisible.

Por lo general, una gran mayoría de tokens posee dieciocho (18) decimales y es tomado como el valor por defecto. Hay otros tokens como el [USDC](https://etherscan.io/token/0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48#code) (con una capitalización de mercado de 28,000 millones de USD) que posee seis (6) decimales. 

Es importante tener en cuenta la cantidad de decimales cuando se trata de hacer intercambios de criptomonedas. Ello porque `10^18` de un token puede ser el equivalente de `10^6` de otro token. Para equiparar un token con otro, a uno de ellos se le debe agregar los decimales que hacen la diferencia entre dichos tokens.

### Set up

Dirigirte a [Wizard de Open Zeppelin](https://wizard.openzeppelin.com/) y crea un token con tu nombre y apellido. Crea una configuración como la que ves a continuación:

![image-20230618085405595](https://github.com/Blockchain-Bites/bbites-ethlima-uni/assets/3300958/38a25cbf-1db5-461c-9d9a-3f5d34c068dc)

Copia este código a Remix. En ambiente cambia a `Injected Provider - Metamask`. Luego le das `Deploy` al contrato a la red `Sepolia`.

![image-20230618085638103](https://github.com/Blockchain-Bites/bbites-ethlima-uni/assets/3300958/e96e59e4-725a-4763-8fa3-5d8e1954d5c6)

Confirmas la transacción cuando se abre la ventana de Metamask y esperamos a que se procese. Cuando la transacción se termine se verán los siguientes métodos:

![image-20230618085906562](https://github.com/Blockchain-Bites/bbites-ethlima-uni/assets/3300958/78699f0c-3313-4b18-b498-e4a8b308cb7b)

### Ethereum Addresses

Ten a la mano dos Ethereum Address para poder realizar este ejercicio. Les vamos a llamar `Address1` y `Address2` a estas billeteras. Aseguráte de tener `Ether`.

`Address1` será el addres que publica el smart contract. Por lo tanto será el `owner` de su contrato token.

### Sepolia red

Utilicen la rede Sepolia para poder publicar e interactuar con este token.

### Estándar ERC20

Una interface en Solidity sirve como un conjunto de reglas autoaplicables para un smart contract. Es decir, cuando un contrato hace uso de una interface (hereda), dicho contrato obligatoriamente debe implementar los método definidos en la interface.

En un interface solo se definen las firmas de los métodos que luego serán implementados en el contrato inteligente que hiciera uso de esa interface. A continuación les presento la interface del estándar ERC20:

```solidity
interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
```

Cuando un contrato hereda esta interface se ve del siguiente modo:

```solidity
contract MiToken is IERC20 {
	// ...
}
```

Ello obliga a que el contrato `MiToken` implemente todos los métodos (`totalSupply`, `transfer`, `allowance`, etc.) que están en la interface.

El contrato que ustedes han creado hereda el contrato `ERC20` que, a su vez, internamente, hereda la interface `IERC20`.

Todos los otros métodos incluidos en el contrato que acaban de publicar pero que no son parte de `IERC20` son comportamientos complementarios.

### Ejercicios

Sigue esta secuencia de pasos para comprender los métodos de un token programable.

1. Consulta el método `name`. Copia aquí el valor de retorno aquí:

2. Consulta el método `symbol`. Copia aquí el valor de retorno aquí:

3. Consulta el método `decimals`. Este valor representa la unidad mínima divisible del token que acabas de crear. Copia aquí el valor de retorno aquí:

4. Consulta el método `totalSupply`. Este cambia con el tiempo y representa la cantidad de tokens acuñados hasta el momento. Los métodos `mint` y `burn` alteran este valor. Copia aquí el valor de retorno aquí:

5. Consulta los balances de `Address1` y `Address2` usando `balanceOf(Address1)` y `balanceOf(Address2)`. El argumento de este método es cualquier address. Este método devuelve el total de tokens acuñados a favor de una address. Copia los valores aquí:

6. Realiza una transferencia usando el método `tansfer(to, cantidad)`. Este método transfiere una cantidad de tokens a otra address debitando al address (`msg.sender`) que llama a este método. Utiliza los siguientes valores en Remix: `to: Address2`, `amount: 10000000000000000000000`. Se está transfiriendo 10,000 tokens. Recuerda que tu token tiene 18 decimales y por ello se agregan 18 ceros extras. Realiza otra vez el punto `5` y consulta los balances. Copia los valores aquí:

7. Acuña tokens a la `Address1` usando el método `mint`. Internamente `mint` agrega un saldo a favor de un address un en mapping de balances:

   ```solidity
   mapping(address => uint256) _balances
   function mint(address to, uint256 amount) public onlyOwner {
   		_balances[to] += amount;
   }
   ```

   En el método `mint` en Remix utiliza los siguientes valores: `to: Address1`,  `amount: 5000000000000000000000`. Vuelve a realizar el punto `5` una vez que la transacción finaliza. Copia los valores aquí:

8. Vamos a quemar todos los tokens del `Address1`. Para ello puedes averiguar el total de balance de tokens que tiene esta address. Se queman los tokenes usando el método `burn`. Utiliza este valor en Remix para ejecutar `mint`: `amount: 45000000000000000000000`. Realizar el paso `5` otra vez. Así también realiza el paso `4`. Nota como los balances y el total supply cambian. Copia los valores aquí:

9. Según el estandar `ERC20`, un `Address A` puede dar permiso a un `Address B` para que `Address B` maneje los tokens de `Address A` en su representación. `Address B` se convierte en un gestor de los activos del `Address A` y `Address B` puede transferir o quemar los tokens del `Address A`. Lograr esto en el estándar se hace a través de `approve`.

   Vamos a lograr que `Address2` le de permiso a `Address1` de manejar sus tokens. Primero vamos a ir a Metamask y vamos a seleccionar el `Address2`. Para ello hacer clic en la extensión de Metamask. Cuando se abra hacer clic en la circunferencia. Seleccionar el `Address2`. Ello se reflejará automáticamente en Remix:

   ![image-20230618114654741](https://github.com/Blockchain-Bites/bbites-ethlima-uni/assets/3300958/fe287d19-8b6f-4403-ba53-1483eec6ab8b)

   En mi caso, el address `0x08Fb288FcC281969A0BBE6773857F99360f2Ca06` representa el `Address2`. Luego me dirijo al método `approve` y digito los siguientes valores: `spender: Address1`, `amount: 10000000000000000000000`. 

   Hacemos clic en `transact` y firmamos la transacción.

   ![image-20230618120215429](https://github.com/Blockchain-Bites/bbites-ethlima-uni/assets/3300958/3d3c44ca-ff19-404f-a4b8-599e9852b90f)

   Metamask volverá a pedir que se digite la cantidad a dar permiso. Poner `10,000`. Luego confirmar la transacción. Nota que aquí en Metamask no es necesario usar los 18 decimales. Sin embargo, antes de ejecutar la transacción, Metamask añade los decimales. Esto es UX solamente.

10. Para indagar el permiso que un `Address A` le dio a otro `Address B`, hacemos uso del método `allowance`. En la terminología del `ERC20`, `owner` hace referencia al dueño de los tokens; mientras que `spender` hace denota al address que recibió el permiso de manejar los tokens.

    En el método `allowance` en Remix usamos los siguientes valores: `owner: Address2`, `spender: Address1`. Esto devolverá el permiso que tiene `Address1` para manejar los tokens de `Address2`. Copia ese valor aquí:

11. Ahora abrimos Metamask para volver a cambiar de cuenta. Regresamos al `Address1`. 

    ![image-20230618115823066](https://github.com/Blockchain-Bites/bbites-ethlima-uni/assets/3300958/04823a47-e31b-42ab-8da0-77415d2a0364)

    En mi caso, `0xCA420CC41ccF5499c05AB3C0B771CE780198555e`, representa el `Address1`. 

    Dado que el `Address1` ahora tiene el poder de manejar los activos del `Address2`, vamos a lograr que `Address1` se transfiera los tokens de `Address2` a sí mismo.

    Usaremos el método `transferFrom` que nos permite definir un address de origen, un address de destino y la cantidad a transferir. Usar los siguientes valores en Remix: `from: Address2`, `to: Address1` y `amount: 10000000000000000000000`.  <u>Nota:</u> `from` hace referencia al dueño de los tokens, a quien se le quitará `amount` tokens; `to` es cualquier address que el gestor de los activos escoja.

    Firmar la transacción. Repetir el punto `5` y anotar los valores aquí:

12. Repite el número `10`. Nota que el permiso que `Address2` le había dado a `Address1` ha cambiado. Copia el valor aquí:

13. Indaga qué hacen los siguientes métodos: `increaseAllowance`, `decreaseAllowance`.