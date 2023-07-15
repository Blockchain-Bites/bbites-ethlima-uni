import { BigNumber, Contract, ethers, utils } from "ethers";

window.ethers = ethers;

var provider, account, signer, subastaContract;

// Importar ABI
var subastaAbi =
  require("../artifacts/contracts/class09/EnglishAuction.sol/EnglishAuction.json").abi;

function setUpMetamask() {
  var bttn = document.getElementById("connect");
  bttn.addEventListener("click", async function () {
    if (window.ethereum) {
      [account] = await ethereum.request({
        method: "eth_requestAccounts",
      });
      console.log("Billetera metamask", account);

      provider = new ethers.BrowserProvider(window.ethereum);
      signer = await provider.getSigner(account);
      window.signer = signer;
    }
  });
}

function setUpListeners() {
  // function creaSubasta(uint256 _startTime, uint256 _endTime)
  // 1. Obtén el botón createAuctionBttn
  var createAuctionBttn;
  // 2. Añade click listener a createAuctionBttn
  // 3. Captura el valor de start time
  // 4. Captura el valor de end time

  // En un try catch
  try {
    // 5.
    // Ejecuta el contrato subastaContract
    // Conectalo con el signer
    // Ejecuta el metodo con sus argumentos
    // Para enviar Ether usar: {value: etherAmount}
    // Esperar que se valide un bloque con await tx.wait();
    // De la respuesta sacar el transaction Hash
  } catch (error) {
    // 6.
    // Si la transacción falla, imprimir 'reason': error.reason
    console.log(error.reason);
  }

  // function proponerOferta(bytes32 _auctionId)

  // function finalizarSubasta(bytes32 _auctionId)

  // function recuperarOferta(bytes32 _auctionId)

  // function verSubastasActivas()

  // Subastas pasadas

  // public auctions:
}

function setUpSmartContracts() {
  // Subasta Contract: Copiar de la red de Sepolia
  var subastaAddress;

  // Proveedor de metamask
  // provider = new ethers.BrowserProvider(window.ethereum);

  // Usando Ethers
  // Contract = address + abi + provider
  // subastaContract = new Contract
}

function setUpEvents() {
  // Escucha al evento SubastaCreada
  // subastaContract.on
  // Escucha al evento OfertaPropuesta
  // subastaContract.on
}

async function setUp() {
  // 1. Inicializar Metamask para obtner signer
  setUpMetamask();

  // 2. Inicializar los smart contracts
  setUpSmartContracts();

  // 3. Inicializar los listeners de los botones
  setUpListeners();

  // 4. Set up Events
  setUpEvents();
}

setUp()
  .then()
  .catch((e) => console.log(e));
