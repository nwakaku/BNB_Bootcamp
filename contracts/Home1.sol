// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract DogeCoin {

    uint TotalSupply = 2000000;
    address owner;

    struct Payment{
        uint amount;
        address recipient;
    }

    mapping(address => uint)balance;
    mapping(address => Payment[]) userFlow;

    event total(uint TotalSupply);
    event transferEvent(uint amount, address recipient);

    constructor(){
        owner = msg.sender;
        balance[owner] = TotalSupply;
    }

    modifier onlyOwner{ // Modifier
        require(
            msg.sender == owner,
            "Only Owner can do this."
        );
        _;
    }

    function getUserBalance() public view returns(uint){
        return balance[msg.sender];
    }


    function GetTotalSupply() public view returns(uint){
        return TotalSupply;
    }

    function _mint() internal onlyOwner returns (uint results) {
        results = TotalSupply;
        TotalSupply += 1000;
        balance[owner] += 1000;
        emit total(TotalSupply);
    }

    function increaseToken() public {
        _mint();
    }

    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Insufficient balance.");
        balance[msg.sender] -= amount;
        balance[recipient] += amount;
        userFlow[msg.sender].push(Payment(amount, recipient));
        userFlow[recipient].push(Payment(amount, msg.sender));
        emit transferEvent(amount, recipient);
    }

    function getRecord() public view returns (Payment[] memory) {
    return userFlow[msg.sender];
}



}