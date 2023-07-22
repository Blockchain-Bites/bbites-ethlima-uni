var {
  loadFixture,
  setBalance,
  impersonateAccount,
} = require("@nomicfoundation/hardhat-network-helpers");
var { expect } = require("chai");
var { ethers } = require("hardhat");
var { toBigInt } = require("ethers");

describe("REENTRANCY", function () {
  async function deployFixture() {
    const [owner, alice, bob, carl] = await ethers.getSigners();

    const Victim = await ethers.getContractFactory("Victim");
    const victim = await Victim.deploy({ value: ethers.parseEther("5") });

    const Attacker = await ethers.getContractFactory("Attacker");
    const attacker = await Attacker.deploy(await victim.getAddress(), {
      value: ethers.parseEther("1"),
    });

    return { victim, attacker, owner, alice };
  }

  async function deployFixtureNoVictim() {
    const [owner, alice, bob, carl] = await ethers.getSigners();

    const NoVictim = await ethers.getContractFactory("NoVictim");
    const noVictim = await NoVictim.deploy({ value: ethers.parseEther("5") });

    const Attacker = await ethers.getContractFactory("Attacker");
    const attacker = await Attacker.deploy(await noVictim.getAddress(), {
      value: ethers.parseEther("1"),
    });
    const Attacker2 = await ethers.getContractFactory("Attacker2");
    const attacker2 = await Attacker2.deploy(await noVictim.getAddress(), {
      value: ethers.parseEther("1"),
    });

    return { noVictim, attacker, attacker2, owner, alice };
  }

  describe("Despliegue ", function () {
    it("Balances iniciales", async () => {
      var { victim, attacker, owner, alice } = await loadFixture(deployFixture);

      var victimBalance = await ethers.provider.getBalance(
        await victim.getAddress()
      );
      expect(victimBalance).to.be.equal(ethers.parseEther("5"));

      var attackerBalance = await ethers.provider.getBalance(
        await attacker.getAddress()
      );
      expect(attackerBalance).to.be.equal(ethers.parseEther("1"));
    });

    xit("Attacker ataca con éxito", async () => {
      var { victim, attacker, owner, alice } = await loadFixture(deployFixture);
      await attacker.attack();

      var victimBalance = await ethers.provider.getBalance(
        await victim.getAddress()
      );
      expect(victimBalance).to.be.equal(ethers.parseEther("0"));

      var attackerBalance = await ethers.provider.getBalance(
        await attacker.getAddress()
      );
      expect(attackerBalance).to.be.greaterThan(ethers.parseEther("5"));
    });
  });

  describe("Victim protegida", () => {
    xit("Protegido check-effects-interactinos", async () => {
      var { noVictim, attacker, owner, alice } = await loadFixture(
        deployFixtureNoVictim
      );
      await expect(attacker.attack()).to.be.reverted;
    });

    xit("Protegido por modifier", async () => {
      var { noVictim, attacker2, owner, alice } = await loadFixture(
        deployFixtureNoVictim
      );
      await expect(attacker2.attack()).to.be.reverted;
    });
  });
});
