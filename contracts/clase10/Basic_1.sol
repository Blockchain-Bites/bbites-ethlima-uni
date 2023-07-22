// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Importar la interfaz del contrato de VRF de Chainlink
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

interface IVRFCoordinator {
    function requestRandomWords(
        bytes32 keyHash,
        uint64 subId,
        uint16 minimumRequestConfirmations,
        uint32 callbackGasLimit,
        uint32 numWords
    ) external returns (uint256 requestId);
}

// 1. Heredar VRFConsumerBaseV2 e inicializar el constructor VRFConsumerBaseV2()
//  contract Basic is VRFConsumerBaseV2  {
contract Basic {
    // Numero random
    uint256 public randomNumber;
    uint256 public randomNumberTwo;

    // 2. definir el address del VRF Coordinator (Polygon Mumbai)

    // 1.1 Inicializando el constructor VRFConsumerBaseV2()
    constructor() /** VRFConsumerBaseV2() */ {

    }

    // Random Numbers en Solidity
    function requestRandomWords(uint256 salt) external {
        randomNumber = uint256(
            keccak256(abi.encode(msg.sender, block.timestamp, salt))
        );
    }

    function requestRandomWordsVRF() external {
        // 3. Crear una referencia al contrato de VRF Coordinator usando la interface IVRFCoordinator
        //
        // 4. Definir los parámetros de llamada al contrato de VRF Coordinator
        // bytes32 keyHash;
        // uint64 s_subscriptionId;
        // uint16 requestConfirmations;
        // uint32 callbackGasLimit;
        // uint32 numWords;
        //
        // 5. Llamar al método requestRandomWords del contrato de VRF Coordinator
        // requestRandomWords( parámetros );
    }

    // 6. Definir el método fulfillRandomWords que es el callback que se ejecuta
    //    cuando se obtiene la respuesta de los números random
    // function fulfillRandomWords(
    //     uint256,
    //     uint256[] memory _randomWords
    // ) internal override {}
}
