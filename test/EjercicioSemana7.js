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

    const Token = await ethers.getContractFactory("TokenEjercicio7");
    const token = await Token.deploy();

    const SwapEtherAndTokens = await ethers.getContractFactory(
      "SwapEtherAndTokens"
    );
    const swapEtherAndTokens = await SwapEtherAndTokens.deploy(
      await token.getAddress()
    );

    const ExecuteOperation = await ethers.getContractFactory(
      "ExecuteOperation"
    );
    const executeOperation = await ExecuteOperation.deploy(
      await swapEtherAndTokens.getAddress(),
      {
        value: toBigInt("1000000000000000000"),
      }
    );

    return {
      token,
      executeOperation,
      swapEtherAndTokens,
      owner,
      alice,
      bob,
      carl,
      otherAccounts,
    };
  }

  describe("Ejecuta operacion con call", function () {
    it("Verifica que contrato recibio tokens a cambio de Ether", async function () {
      const { token, executeOperation, swapEtherAndTokens } = await loadFixture(
        deployFixture
      );

      await executeOperation.executeWithCall();

      var ratio = 2500;
      var balanceExecuteOp = await token.balanceOf(
        await executeOperation.getAddress()
      );
      expect(balanceExecuteOp.toString()).to.be.equal("2500000000000000000000");
    });

    it("Verifica que SwapEtherAndTokens recibió Ether", async function () {
      const { token, executeOperation, swapEtherAndTokens } = await loadFixture(
        deployFixture
      );

      await executeOperation.executeWithCall();

      var balanceSwap = await ethers.provider.getBalance(
        await swapEtherAndTokens.getAddress()
      );
      expect(balanceSwap.toString()).to.be.equal("1000000000000000000");
    });

    it("Retir de Ether", async function () {
      const { token, executeOperation, swapEtherAndTokens, owner } =
        await loadFixture(deployFixture);

      await executeOperation.executeWithCall();

      const wallet = ethers.Wallet.createRandom();
      var tx = await swapEtherAndTokens.withdrawEther(wallet.address);

      await expect(tx).to.changeEtherBalances(
        [wallet.address, await swapEtherAndTokens.getAddress()],
        [toBigInt("1000000000000000000"), -toBigInt("1000000000000000000")]
      );
    });
  });

  describe("Ejecuta operacion con receive", function () {
    it("Verifica que contrato recibio tokens a cambio de Ether", async function () {
      const { token, executeOperation, swapEtherAndTokens } = await loadFixture(
        deployFixture
      );

      await executeOperation.executeReceive();

      var ratio = 2500;
      var balanceExecuteOp = await token.balanceOf(
        await executeOperation.getAddress()
      );
      expect(balanceExecuteOp.toString()).to.be.equal("2500000000000000000000");
    });

    it("Verifica que SwapEtherAndTokens recibió Ether", async function () {
      const { token, executeOperation, swapEtherAndTokens } = await loadFixture(
        deployFixture
      );

      await executeOperation.executeReceive();

      var balanceSwap = await ethers.provider.getBalance(
        await swapEtherAndTokens.getAddress()
      );
      expect(balanceSwap.toString()).to.be.equal("1000000000000000000");
    });

    it("Retir de Ether", async function () {
      const { token, executeOperation, swapEtherAndTokens, owner } =
        await loadFixture(deployFixture);

      await executeOperation.executeReceive();

      const wallet = ethers.Wallet.createRandom();
      var tx = await swapEtherAndTokens.withdrawEther(wallet.address);

      await expect(tx).to.changeEtherBalances(
        [wallet.address, await swapEtherAndTokens.getAddress()],
        [toBigInt("1000000000000000000"), -toBigInt("1000000000000000000")]
      );
    });
  });
});
