// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract BadgerCoin is ERC20, Pausable, Ownable, ERC20Burnable {
    constructor() ERC20("BadgerCoin", "BC") {
        _mint(msg.sender, 1000000);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public whenNotPaused onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function approveSpend(address owner, address spender, uint256 amount) public whenNotPaused {
        _approve(owner, spender, amount);
    }

    function transferA(address from, address to, uint256 amount) public whenNotPaused {
        _transfer(from, to, amount);
    }

    function burnToken(address account, uint256 amount) public whenNotPaused {
        _burn(account, amount);
    }

}