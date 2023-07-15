var { ethers } = require("hardhat");

async function main() {
  var _collectionName = "STEVE MARREROS NFT COLLECTION";
  var _collectionSymbol = "STVMRRNFTCLL";

  // 1 publicar el smart contract
  const miPrimerNft = await ethers.deployContract("MiPrimerNft", [
    _collectionName,
    _collectionSymbol,
  ]);

  // obtener el address
  const address = await miPrimerNft.getAddress();
  console.log("SC address", address);

  // 2 esperar a que se publiqu en la red (progague info)
  await miPrimerNft.waitForDeployment();
  const delay = 30 * 1000; // 30 segundos
  await new Promise((resolve) => setTimeout(resolve, delay));

  // 3 verificar smart contract
  await hre.run("verify:verify", {
    address: await miPrimerNft.getAddress(),
    constructorArguments: [_collectionName, _collectionSymbol],
  });

  // EJECTUAR SCRIPT DESDE TERMINAL
  // npx hardhat --network sepolia run ./scripts/deployMiPrimerNFT.js
}

async function mint() {}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1; // exitcode quiere decir fallor por error, terminacion fatal
});
