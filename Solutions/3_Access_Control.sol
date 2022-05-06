// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract HouseRentAgreement {
    address private owner;
    uint256 public rent;

    constructor(uint256 _rent) {
        owner = msg.sender;
        rent = _rent;
    }

    function setRent(uint256 _rent) public onlyOwner {
        rent = _rent;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only the owner can update the rent");
        _;
    }
}
