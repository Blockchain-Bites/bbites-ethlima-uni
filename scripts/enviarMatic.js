const hre = require("hardhat");

async function main() {
  // Direcciones de las cuentas a las que se enviará Matic
  const addresses = [
    "0x990ceDaE234b4254c26daedf763567840a2d5fd2",
    "0x2Ea3c8e484CE1977d67f0407fED8915634e25b7f",
    "0x0c4d311c5128AEF9eF7b303d607F1a09eAfE0891",
    "0xea12b231357a8Fe6126a4F1e21Fd58947043f2a6",
    "0x60b22cb3b6915A9a4bD554325916f9e2E721cc71",
    "0x88433E5D3c610Ecd400C3D9Ec077f57012Aef91B",
    "0xC006e19bD4E8B45E98e1Cde7330e421709683FaB",
  ];

  const amountToSend = hre.ethers.parseEther("0.15");

  const [sender] = await hre.ethers.getSigners();

  // Iterar a través de las direcciones y enviar los Matic
  for (const address of addresses) {
    // Crear una transacción para enviar Matic a la dirección actual
    const transaction = await sender.sendTransaction({
      to: address,
      value: amountToSend,
    });

    console.log(`Matic enviado a ${address}. Tx hash: ${transaction.hash}`);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
