const { expect } = require("chai");

describe("BadgerCoin", function () {
  let badgerCoin;
  let owner;
  let addr1;
  let addr2;

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();
    const BadgerCoin = await ethers.getContractFactory("BadgerCoin");
    badgerCoin = await BadgerCoin.deploy();
  });

  describe("minting and transferring", function () {
    it("The total supply should initially be 1000000", async function () {
      //   await badgerCoin.connect(owner).mint(owner.address, 1);

      const totalSupply = await badgerCoin.totalSupply();
      expect(totalSupply).to.equal(1000000);
    });

    it("try to mint more token when paused", async function () {
      await badgerCoin.pause();
      await expect(badgerCoin.mint(owner.address, 5000)
      ).to.be.revertedWith("Pausable: paused");
    })

    it("That the number of decimals is 18", async function () {
      const decimal = await badgerCoin.decimals();
      expect(decimal).to.equal(18);
    });

    it("The balanceOf function returns the correct result", async function () {
      const totalSupply = await badgerCoin.totalSupply();
      const balanceOf = await badgerCoin.balanceOf(owner.address);
      expect(balanceOf).to.equal(totalSupply);
    });

    it("The transfer function works correctly", async function () {
      await badgerCoin.pause();
      await expect(
        badgerCoin.transferA(owner.address, addr1.address, 2000)
      ).to.be.revertedWith("Pausable: paused");
      // const balanceOf = await badgerCoin.balanceOf(addr1.address);
      // expect(balanceOf).to.equal(2000);
    })

    it("Test that an error is produced if a transfer is created with an insufficient balance", async function () {
      const transferAmount = 1000001;
      await expect(
        badgerCoin.connect(owner).transfer(addr1.address, transferAmount)
      ).to.be.revertedWith("ERC20: transfer amount exceeds balance");

      // Check that the balance of the owner is unchanged
      expect(await badgerCoin.balanceOf(owner.address)).to.equal(1000000);

    })

    it("try to burn token when its paused", async function () {
      await badgerCoin.pause();
      const transferAmount = 1000;
      await expect(
        badgerCoin.burnToken(owner.address, transferAmount)
      ).to.be.revertedWith("Pausable: paused");

      // Check that the balance of the owner is unchanged
    });

    it("when approve is paused", async function () {
      await badgerCoin.pause();
      const amt = 1000;
      await expect(
        badgerCoin.approveSpend(owner.address, addr1.address, amt)
      ).to.be.revertedWith("Pausable: paused");
    });
  });
});
