// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract InvestDaoCore is ERC20{

    uint256 internal contractBalance;

    struct Proposal {
        address owner;
        uint128 proposalID;
        string proposalLink;
    }

    uint128 nonce;
    Proposal[] proposals;

    mapping (address => uint256) stakedBalance;
    uint256 totalStaked;

    constructor()
    ERC20("InvestDAO", "IDAO")
    {}

    function wrap() public payable returns (bool) {

        _mint(msg.sender, msg.value);
        contractBalance += msg.value;
        return true;
    }

    function stake(uint256 amount) public {
        stakedBalance[msg.sender] += amount;
        totalStaked += amount;
    }

    function unstake(uint256 amount) public {

        //solidity makes sure unsigned ints don't go below 0
        stakedBalance[msg.sender] -= amount;
        totalStaked -= amount;
    }

    //view functions view some value on the blockchain
    function getStakedBalance(address account) public view returns (uint256) {
        return stakedBalance[account];
    }
    //pure functions require no gas as they do not require the blockchain

    //calldata comes from user input (strings or struct)
    function createProposal(string calldata link) public {
        nonce++;
        Proposal memory p = Proposal(msg.sender, nonce, link);
        proposals.push(p);
    }
}