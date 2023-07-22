var {
  loadFixture,
  setBalance,
  impersonateAccount,
} = require("@nomicfoundation/hardhat-network-helpers");
var { expect } = require("chai");
var { ethers } = require("hardhat");
var { toBigInt } = require("ethers");

describe("Testeando un NFT", function () {
  async function deployFixture() {
    // ...
    // return { miPrimerNft, owner, alice, bob, carl };
  }

  describe("Presentación", function () {
    it("Verifica nombre de la colección", async function () {
      // const { miPrimerNft, owner, alice, bob, carl } = await loadFixture(
      //   deployFixture
      // );
    });
    it("Verifica simbolo de la colección", async function () {});
  });

  describe("Metadata", () => {
    it("Verifica correcto URI", async () => {});
  });

  describe("Acuñando NFTs", function () {
    it("Incrementa balance de NFTs", async function () {});
    it("Verifica token IDs corrects", async () => {});
    it("Emit evento cuando se acuña", async () => {});
    it("No acuña dos NFT con el mismo id", async () => {});
  });

  describe("Transferencia", () => {
    it("Correcto transfer", async () => {});
  });
});
