const { expect } = require("chai");

describe("BadgerNFT", function () {
  let badgerNFT;
  let owner;
  let addr1;
  let addr2;

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();
    const BadgerNFT = await ethers.getContractFactory("BadgerNFT");
    badgerNFT = await BadgerNFT.deploy();
  });

  describe("minting and transferring", function () {
    it("should allow the owner to mint a new token and transfer it to another address", async function () {
      const uri = "https://example.com/token/1";
      await badgerNFT.connect(owner).safeMint(addr1.address, uri);

      const balanceBefore = await badgerNFT.balanceOf(addr1.address);
      expect(balanceBefore).to.equal(1);

      const tokenId = await badgerNFT.tokenOfOwnerByIndex(addr1.address, 0);
      console.log(tokenId);
      expect(await badgerNFT.tokenURI(tokenId)).to.equal(uri);

      await badgerNFT
        .connect(addr1)
        .transferAsset(addr1.address, addr2.address, tokenId);

      const balanceAfter = await badgerNFT.balanceOf(addr2.address);
      expect(balanceAfter).to.equal(1);
    });
  });
});
