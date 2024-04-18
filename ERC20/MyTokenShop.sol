// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./MyToken.sol";

struct Item {
    uint256 price;
    uint256 quantity;
    string name;
    bool exists;
}

struct ItemInStock {
    bytes32 uid;
    uint256 price;
    uint256 quantity;
    string name;
}

struct BoughtItem {
    bytes32 uniqueId;
    uint256 numOfPurchasedItems;
    string deliveryAddress;
}

contract MyTokenShop {
    mapping(bytes32 => Item) public items;
    bytes32[] public uniqueIds;

    mapping(address => BoughtItem[]) public buyers;

    MyToken public mtk;

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "not an owner");
        _;
    }

}