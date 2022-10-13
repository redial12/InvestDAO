const { expect } = require("chai");
const{ ethers } = require("hardhat");

let owner, user, user2;
let ownerAddress, userAddress, user2Address;

describe("InvestDAOCore", function () {
  before(async function() {
    [owner, user, user2] = await ethers.getSigners();
    ownerAddress = owner.address;
    userAddress = user.address;
    user2Address = user2.address;
    const Token = await ethers.getContractFactory("InvestDaoCore");
    this.investdao = await Token.deploy();
  });

  describe("ERC20 Traits", function () {
    it("mints tokens to user", async function () {
        await this.investdao.connect(user).wrap({value : "1000"});
        expect(await this.investdao.balanceOf(userAddress)).to.eq("1000");
        expect(await this.investdao.totalSupply()).to.eq("1000");
    });
    it("transfers tokens to other user", async function () {
        await this.investdao.connect(user).transfer(user2Address, '500');
        expect(await this.investdao.balanceOf(user2Address)).to.eq("500");
        expect(await this.investdao.totalSupply()).to.eq("1000");
    });
  })
});