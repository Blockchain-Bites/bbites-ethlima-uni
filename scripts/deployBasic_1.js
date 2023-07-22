const { ethers } = require("hardhat");

async function main() {
  const Basic = await ethers.getContractFactory("Basic");
  const basic = await Basic.deploy();
  var tx = await basic.deploymentTransaction();
  await tx.wait(10);

  var basicAddress = await basic.getAddress();
  console.log("Basic deployed to:", basicAddress);

  // verify smart contract
  await hre.run("verify:verify", {
    address: basicAddress,
    constructorArguments: [],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
