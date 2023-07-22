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
  var createAuctionBttn = document.getElementById("createAuctionButton");
  // 2. Añade click listener a createAuctionBttn
  createAuctionBttn.addEventListener("click", async function () {
    // 3. Captura el valor de start time
    var inputStartTime = document.getElementById("startTimeId");
    // 4. Captura el valor de end time
    var inputEndTime = document.getElementById("endTimeId");

    // En un try catch
    try {
      // 5.
      // Ejecuta el contrato subastaContract
      // Conectalo con el signer
      // Ejecuta el metodo con sus argumentos
      // Para enviar Ether usar: {value: etherAmount}
      // Esperar que se valide un bloque con await tx.wait();
      // De la respuesta sacar el transaction Hash
      var tx = await subastaContract
        .connect(signer)
        .creaSubasta(inputStartTime.value, inputEndTime.value, {
          value: 1,
        });
      var response = await tx.wait();
      console.log("Tx Hash", response.hash);
    } catch (error) {
      // 6.
      // Si la transacción falla, imprimir 'reason': error.reason
      console.log(error.reason);
    }
    inputStartTime.innerHTML = "";
    inputEndTime.innerHTML = "";
  });

  // function proponerOferta(bytes32 _auctionId)
  var proposeOfferBttn = document.getElementById("proposeOfferBttn");
  proposeOfferBttn.addEventListener("click", async function () {
    var auctionId = document.getElementById("offerAuctionIdInput");
    var offerAmount = document.getElementById("offerAmountInput");

    try {
      var tx = await subastaContract
        .connect(signer)
        .proponerOferta(auctionId.value, {
          value: offerAmount.value,
        });
      var response = await tx.wait();
      var transactionHash = response.hash;
      console.log("Tx Hash", transactionHash);
    } catch (error) {
      console.log(error.reason);
    }

    auctionId.innerHTML = "";
  });

  // function finalizarSubasta(bytes32 _auctionId)
  var endAuctionBttn = document.getElementById("endAuctionBttn");
  endAuctionBttn.addEventListener("click", async function () {
    var auctionId = document.getElementById("endAuctionIdInput");
    var endAuctionError = document.getElementById("endAuctionError");
    endAuctionError.innerHTML = "";
    try {
      var tx = await subastaContract
        .connect(signer)
        .finalizarSubasta(auctionId.value);
      var response = await tx.wait();
      var transactionHash = response.hash;
      console.log("Tx Hash", transactionHash);
    } catch (error) {
      console.log(error.reason);
      endAuctionError.innerHTML = error.reason;
    }
  });

  // function recuperarOferta(bytes32 _auctionId)
  var withdrawOfferBttn = document.getElementById("withdrawOfferBttn");
  withdrawOfferBttn.addEventListener("click", async function () {
    var auctionId = document.getElementById("withdrawOfferInput");
    try {
      var tx = await subastaContract
        .connect(signer)
        .recuperarOferta(auctionId.value);
      var response = await tx.wait();
      var transactionHash = response.hash;
      console.log("Tx Hash", transactionHash);
    } catch (error) {
      console.log(error.reason);
    }
  });

  // function verSubastasActivas()
  var activeAuctionBttn = document.getElementById("activeAuctionBttn");
  activeAuctionBttn.addEventListener("click", async function () {
    var list = document.getElementById("liveAuctionsList");
    list.innerHTML = "";

    var res = await subastaContract.verSubastasActivas();
    console.log(res);
    res.forEach((subastaActiva, ix) => {
      var child = document.createElement("li");
      child.innerText = `Subasta ${ix + 1}: ${subastaActiva}`;
      list.appendChild(child);
    });
  });

  // Subastas pasadas
  var pastAuctionBttn = document.getElementById("pastAuctionBttn");
  pastAuctionBttn.addEventListener("click", async function () {
    var list = document.getElementById("pastAuctionsList");
    list.innerHTML = "";

    var res = await subastaContract.verSubastasPasadas();
    res.forEach((subastaPasada, ix) => {
      var child = document.createElement("li");
      child.innerText = `Subasta ${ix + 1}: ${subastaPasada}`;
      list.appendChild(child);
    });
  });

  // public auctions:
  var consultAuctionBttn = document.getElementById("consultAuctionBttn");
  consultAuctionBttn.addEventListener("click", async function () {
    var consultAuctionInput = document.getElementById("consultAuctionInput");
    var auctionInfoArr = await subastaContract.auctions(
      consultAuctionInput.value
    );

    var labels = ["startTime", "endTime", "highestBidder", "highestBid"];
    var auctionInfoId = document.getElementById("auctionInfoId");

    auctionInfoArr.forEach((info, ix) => {
      var child = document.createElement("li");
      child.innerHTML = `${labels[ix]}: ${info}`;
      auctionInfoId.appendChild(child);
    });
  });
}

function setUpSmartContracts() {
  // Subasta Contract: Copiar de la red de Mumbai
  var subastaAddress = "0x408a408d0A5EcdD3450B524F84f7e6649a9a159D";

  // Proveedor de metamask
  provider = new ethers.BrowserProvider(window.ethereum);

  // Usando Ethers
  // Contract = address + abi + provider
  subastaContract = new Contract(subastaAddress, subastaAbi, provider);
  window.subastaContract = subastaContract;
}

function setUpEvents() {
  // Escucha al evento SubastaCreada
  subastaContract.on("SubastaCreada", (auctionId, billeteraCreador) => {
    console.log("auctionId", auctionId);
    console.log("billeteraCreador", billeteraCreador);
  });

  // Escucha al evento OfertaPropuesta
  subastaContract.on("OfertaPropuesta", (billeteraOfertante, montoOferta) => {
    console.log("billeteraOfertante", billeteraOfertante);
    console.log("montoOferta", montoOferta);
  });
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
