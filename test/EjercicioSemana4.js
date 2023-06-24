var {
  loadFixture,
  setBalance,
  impersonateAccount,
} = require("@nomicfoundation/hardhat-network-helpers");
var { expect } = require("chai");
var { ethers } = require("hardhat");
var { toBigInt } = require("ethers");

describe("Cajero Automatico", function () {
  async function deployFixture() {
    const [owner, alice, bob, carl] = await ethers.getSigners();
    const otherAccounts = [alice, bob, carl];

    const CajeroAutomatico = await ethers.getContractFactory(
      "EjercicioSemana4Sol"
    );
    const cajeroAutomatico = await CajeroAutomatico.deploy();

    return { cajeroAutomatico, owner, alice, bob, carl, otherAccounts };
  }

  describe("Deposito", function () {
    it("Incrementa balance de usuario", async function () {
      const { cajeroAutomatico, otherAccounts } = await loadFixture(
        deployFixture
      );

      var account, balance;
      account = otherAccounts[0];

      await cajeroAutomatico.connect(account).depositar(1000);
      balance = await cajeroAutomatico.balances(account.address);
      expect(balance).to.equal(1000);

      account = otherAccounts[1];
      await cajeroAutomatico.connect(account).depositar(2000);
      balance = await cajeroAutomatico.balances(account.address);
      expect(balance).to.equal(2000);
    });

    it("Incrementa balance de cajero", async function () {
      const { cajeroAutomatico, otherAccounts } = await loadFixture(
        deployFixture
      );

      var account, balance;
      account = otherAccounts[0];

      await cajeroAutomatico.connect(account).depositar(1000);
      await cajeroAutomatico.connect(account).depositar(2000);
      balance = await cajeroAutomatico.balanceTotal();
      expect(balance).to.equal(3000);
    });

    it("Se dispara evento Deposit", async function () {
      const { cajeroAutomatico, otherAccounts } = await loadFixture(
        deployFixture
      );

      var account, balance, tx;
      account = otherAccounts[0];

      tx = await cajeroAutomatico.connect(account).depositar(1000);
      await expect(tx)
        .to.emit(cajeroAutomatico, "Deposit")
        .withArgs(account.address, 1000);

      account = otherAccounts[1];
      tx = await cajeroAutomatico.connect(account).depositar(2000);
      await expect(tx)
        .to.emit(cajeroAutomatico, "Deposit")
        .withArgs(account.address, 2000);
    });
  });

  describe("Retiro", function () {
    var cajeroAutomatico, otherAccounts;

    beforeEach(async function () {
      const fixture = await loadFixture(deployFixture);
      cajeroAutomatico = fixture.cajeroAutomatico;
      otherAccounts = fixture.otherAccounts;

      await cajeroAutomatico.connect(otherAccounts[0]).depositar(1000);
      await cajeroAutomatico.connect(otherAccounts[1]).depositar(2000);
    });

    it("Disminuye balance usuario", async function () {
      await cajeroAutomatico.connect(otherAccounts[0]).retirar(400);
      var balance = await cajeroAutomatico.balances(otherAccounts[0].address);
      expect(balance).to.equal(600);

      await cajeroAutomatico.connect(otherAccounts[1]).retirar(500);
      var balance = await cajeroAutomatico.balances(otherAccounts[1].address);
      expect(balance).to.equal(1500);
    });

    it("Disminuye balance de cajero", async function () {
      await cajeroAutomatico.connect(otherAccounts[0]).retirar(400);
      await cajeroAutomatico.connect(otherAccounts[1]).retirar(500);

      var balance = await cajeroAutomatico.balanceTotal();
      expect(balance).to.equal(2100);
    });

    it("Usuario no tiene saldo suficiente", async function () {
      await expect(
        cajeroAutomatico.connect(otherAccounts[2]).retirar(10000)
      ).to.revertedWith("Saldo insuficiente");
    });

    it("Se dispara evento Withdraw", async function () {
      var tx = await cajeroAutomatico.connect(otherAccounts[0]).retirar(400);
      await expect(tx)
        .to.emit(cajeroAutomatico, "Withdraw")
        .withArgs(otherAccounts[0].address, 400);
    });
  });

  describe("Transferir", function () {
    var cajeroAutomatico, otherAccounts;

    beforeEach(async function () {
      const fixture = await loadFixture(deployFixture);
      cajeroAutomatico = fixture.cajeroAutomatico;
      otherAccounts = fixture.otherAccounts;

      await cajeroAutomatico.connect(otherAccounts[0]).depositar(1000);
      await cajeroAutomatico.connect(otherAccounts[1]).depositar(2000);
    });

    it("Disminuye balance usuario", async function () {
      await cajeroAutomatico
        .connect(otherAccounts[0])
        .transferir(otherAccounts[2].address, 500);

      var balance = await cajeroAutomatico.balances(otherAccounts[0].address);
      expect(balance).to.equal(500);
    });

    it("Incrementa balance recipiente", async function () {
      await cajeroAutomatico
        .connect(otherAccounts[0])
        .transferir(otherAccounts[2].address, 500);

      var balance = await cajeroAutomatico.balances(otherAccounts[2].address);
      expect(balance).to.equal(500);
    });

    it("Dispara Error si saldo insuficiente", async function () {
      await expect(
        cajeroAutomatico
          .connect(otherAccounts[2])
          .transferir(otherAccounts[0].address, 500)
      ).to.revertedWithCustomError(cajeroAutomatico, "SaldoInsuficiente");
    });

    it("Emite evento personalizado de Transfer", async function () {
      var tx = await cajeroAutomatico
        .connect(otherAccounts[0])
        .transferir(otherAccounts[2].address, 500);
      await expect(tx)
        .to.emit(cajeroAutomatico, "Transfer")
        .withArgs(otherAccounts[0].address, otherAccounts[2].address, 500);
    });
  });

  describe("Pausado", function () {
    var cajeroAutomatico, otherAccounts;

    beforeEach(async function () {
      const fixture = await loadFixture(deployFixture);
      cajeroAutomatico = fixture.cajeroAutomatico;
      otherAccounts = fixture.otherAccounts;

      await cajeroAutomatico.connect(otherAccounts[0]).depositar(1000);
    });

    it("Solo el admin puede llamarlo", async function () {
      await expect(cajeroAutomatico.cambiarPausado()).to.be.revertedWith(
        "Solo el admin puede ejecutar esta funcion"
      );
    });

    it("El admin cambia a true 'pausado'", async function () {
      var admin = "0x08Fb288FcC281969A0BBE6773857F99360f2Ca06";
      await setBalance(admin, toBigInt("100000000000000000000"));
      await impersonateAccount(admin);

      var adminSigner = await ethers.provider.getSigner(admin);
      await cajeroAutomatico.connect(adminSigner).cambiarPausado();
    });

    it("Boolean 'pausado' empieza en 'false'", async function () {
      expect(await cajeroAutomatico.pausado()).to.be.false;
    });

    it("Si 'pausado = true' no se puede retirar'", async function () {
      var admin = "0x08Fb288FcC281969A0BBE6773857F99360f2Ca06";
      await setBalance(admin, toBigInt("100000000000000000000"));
      await impersonateAccount(admin);

      var adminSigner = await ethers.provider.getSigner(admin);
      await cajeroAutomatico.connect(adminSigner).cambiarPausado();

      await expect(
        cajeroAutomatico.connect(otherAccounts[0]).retirar(100)
      ).to.be.revertedWith("El contrato esta pausado");
    });
  });
});
