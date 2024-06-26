// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "./ERC20.sol";
import "./ERC20Burnable.sol";

contract MyToken is ERC20, ERC20Burnable {
    address owner;
    modifier onlyOwner() {
        require(owner == msg.sender);
       _;
    }
    constructor(address initialOwner) ERC20("MyToken", MTK) {
        owner = initialOwner;
        _mint(msg.sender, 5 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}