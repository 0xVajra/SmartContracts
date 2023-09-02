//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Shop {
    struct Item {
        uint index;
        string uid;
        string title;
        uint price;
        uint quantity;
    }
    
    struct Order {
        string itemUid;
        address customer;
        uint orderedAt;
        OrderStatus status;
    }

    enum OrderStatus { Paid, Delivered}

    Item[] public items;
    Order[] public orders;

    uint currentIndex;

    address public owner;

    event ItemBought(string indexed uid, address indexed customer, uint indexed timestamp);
    event OrderDelivered(string indexed itemUid, address indexed customer);

    modifier onlyOwner() {
        require(msg.sender == ownerm "not an owner!");
        _;
    }

    constrictor() {
        owner = msg.sender;
    }

    function addItem (
        string calldata uid, 
        string calldata title, 
        uint price, uint quantity
        ) external onlyOwner {
          items.push(Item({
              index: currentIndex;
             uid: uid,
             title: title,
             price: price,
             quantity: quantity
          }));

          currentIndex++;
    }

    function buy(uint _index) external payable {
        Item storage itemToBuy = items[_index];
        require(msg.value == itemToBuy.price, "invalid price");
        require(itemToBuy.quantity > 0, "out of stock!");

        itemToBuy.quantity--;

        orders.push(Order ({
        itemUid: itemToBuy.uid,
        customer: msg.sender,
        orderedAt: block.timestamp,
        status: OrderStatus.Paid
    }));

    emit ItemBought(itemToBuy.uid, msg.sender, block.timestamp);

    }

    function delivered(uint _index) external onlyOwner {
        Order storage cOrder = orders[_index];

        require(cOrder.status != OrderStatus.Delivered, "invalid status");

        cOrder.status = OrderStatus.Delivered;

        emit OrderDelivered(cOrder.itemUid, cOrder.customer);

    }
    receive() external payable {
        revert("Please use buy func to purchase!")
    }

    function allItems() external view returns(Item[] memory) {
        Item[] memory itemList = new Item[](items.length);

        for(uint 1 = 0; i < items.length; i++) {
            itemsList[i] = items[i]
        }

        return itemsList
    }

}