var { ethers } = require("hardhat");

async function main() {
  const englishAuction = await ethers.deployContract("EnglishAuction");

  await englishAuction.waitForDeployment();

  const address = await englishAuction.getAddress();
  console.log("SC address", address);

  const delay = 30 * 1000; // 30 segundos
  await new Promise((resolve) => setTimeout(resolve, delay));

  await hre.run("verify:verify", {
    address,
    constructorArguments: [],
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
