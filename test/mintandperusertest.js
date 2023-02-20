const { expect } = require("chai");

describe("Token contract", function () {
let RenesisNFT;
let renesisnft;
  let owner;
  let addr1;
  let addr2;

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();

    RenesisNFT= await ethers.getContractFactory("RenesisNFT");
    renesisnft = await RenesisNFT.deploy();
    await renesisnft.deployed();
  });

  describe("minting", function () {
    it("should mint a token", async function () {
        await renesisnft.safeMint(addr1.address, "tokenURI");
        expect(await renesisnft.ownerOf(0)).to.equal(addr1.address);
      });
    it("should not allow a user to mint more than the maximum limit", async function () {
        for (let i = 0; i < 5; i++) {
          await token.safeMint(addr1.address, "tokenURI");
        }
    
        await expect(token.safeMint(addr1.address, "tokenURI")).to.be.revertedWith("you have reached the max Renesis per wallet and user.");
        expect(await token.totalSupply()).to.equal(5);
      });


  
  });
});