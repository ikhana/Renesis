const { expect } = require("chai");

describe("Token contract", function () {
  let RenesisNFT;
  let renesisnft;
  let owner;
  let addr1;
  let addr2;

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();

    RenesisNFT = await ethers.getContractFactory("RenesisNFT");
    renesisnft = await RenesisNFT.deploy();
    await renesisnft.deployed();
  });

  describe("minting", function () {
    it("should mint a token", async function () {
      await renesisnft.safeMint(addr1.address, "tokenURI");
      expect(await renesisnft.ownerOf(0)).to.equal(addr1.address);
    });

    it("should not mint more tokens than the maximum supply", async function () {
      for (let i = 0; i < 100; i++) {
        await renesisnft.safeMint(addr1.address, "tokenURI");
      }

      await expect(renesisnft.safeMint(addr1.address, "tokenURI")).to.be.revertedWith("maximum number of REnesis NFT's have been minted");
      expect(await renesisnft.totalSupply()).to.equal(100);
    });

  
  });
});
